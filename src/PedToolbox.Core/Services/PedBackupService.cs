using System.ServiceProcess;
using System.Text;
using Microsoft.Win32;
using PedToolbox.Core.Logging;

namespace PedToolbox.Core.Services;

/// <summary>
/// Native equivalent of v1 PED backup into %SystemDrive%\PED-Recovery (or LocalAppData fallback).
/// Writes restore scripts for tasks and services; exports registry files.
/// </summary>
public sealed class PedBackupService
{
    private readonly ActivityLog _log;
    private readonly ProcessRunner _runner;

    public PedBackupService(ActivityLog log, ProcessRunner runner)
    {
        _log = log;
        _runner = runner;
    }

    public string DefaultRoot
    {
        get
        {
            var drive = Path.GetPathRoot(Environment.SystemDirectory) ?? @"C:\";
            return Path.Combine(drive, "PED-Recovery");
        }
    }

    public async Task<PedBackupReport> CreateSnapshotAsync(
        bool fullRegistry,
        bool exportDrivers,
        CancellationToken cancellationToken = default)
    {
        var stamp = DateTime.Now.ToString("yyyyMMdd-HHmmss");
        var folder = Path.Combine(EnsureRoot(), stamp);
        Directory.CreateDirectory(folder);
        var report = new PedBackupReport { Folder = folder };

        await Task.Run(() =>
        {
            WriteReadme(folder, fullRegistry, exportDrivers);
            report.Files.AddRange(ExportUserRegistry(folder));
            report.Files.AddRange(ExportStartMenu(folder));
            report.Files.AddRange(ExportWinKey(folder));
            report.Files.AddRange(ExportServices(folder));
            report.Files.AddRange(ExportTasks(folder));
            if (fullRegistry)
                report.Files.AddRange(ExportFullHives(folder));
            if (exportDrivers)
                report.Files.AddRange(ExportDrivers(folder));
        }, cancellationToken);

        _log.Ok("Backup", $"Snapshot {folder} ({report.Files.Count} files)");
        return report;
    }

    public void OpenRoot()
    {
        var root = EnsureRoot();
        _runner.StartDetached(root);
    }

    private string EnsureRoot()
    {
        try
        {
            Directory.CreateDirectory(DefaultRoot);
            var probe = Path.Combine(DefaultRoot, ".write");
            File.WriteAllText(probe, "ok");
            File.Delete(probe);
            return DefaultRoot;
        }
        catch
        {
            var fallback = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                "PEDToolbox",
                "PED-Recovery");
            Directory.CreateDirectory(fallback);
            _log.Warn("Backup", $"Cannot write {DefaultRoot}, using {fallback}");
            return fallback;
        }
    }

    private List<string> ExportUserRegistry(string folder)
    {
        var files = new List<string>();
        var hkcu = Path.Combine(folder, "HKCU.reg");
        var result = _runner.Run("reg.exe", $"export HKCU \"{hkcu}\" /y", "Backup.HKCU", timeoutMs: 180_000);
        if (result.Succeeded && File.Exists(hkcu)) files.Add(hkcu);
        return files;
    }

    private List<string> ExportFullHives(string folder)
    {
        if (!AdminService.IsAdministrator())
        {
            _log.Warn("Backup", "Full hive export needs administrator.");
            return [];
        }

        var files = new List<string>();
        foreach (var hive in new[] { "HKLM", "HKCR", "HKU", "HKCC" })
        {
            var path = Path.Combine(folder, hive + ".reg");
            _log.Info("Backup", $"Exporting {hive} (slow)...");
            var result = _runner.Run("reg.exe", $"export {hive} \"{path}\" /y", "Backup." + hive, timeoutMs: 600_000);
            if (result.Succeeded && File.Exists(path)) files.Add(path);
        }
        return files;
    }

    private List<string> ExportStartMenu(string folder)
    {
        var path = Path.Combine(folder, "StartMenu-CloudStore.reg");
        var key = @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount";
        var result = _runner.Run("reg.exe", $"export \"{key}\" \"{path}\" /y", "Backup.StartMenu", timeoutMs: 60_000);
        return result.Succeeded && File.Exists(path) ? [path] : [];
    }

    private List<string> ExportWinKey(string folder)
    {
        try
        {
            using var key = Registry.LocalMachine.OpenSubKey(
                @"SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform");
            var value = key?.GetValue("BackupProductKeyDefault")?.ToString();
            var path = Path.Combine(folder, "winKey.txt");
            var text = string.IsNullOrWhiteSpace(value)
                ? "BackupProductKeyDefault was not present (normal on many digital licenses)."
                : value;
            File.WriteAllText(path, text + Environment.NewLine);
            return [path];
        }
        catch (Exception ex)
        {
            _log.Warn("Backup", "WinKey read failed.", ex.Message);
            return [];
        }
    }

    private List<string> ExportServices(string folder)
    {
        var sb = new StringBuilder();
        sb.AppendLine("@echo off");
        sb.AppendLine("REM Generated by PED Toolbox v3. Run as administrator to restore startup types.");
        try
        {
            foreach (var svc in ServiceController.GetServices().OrderBy(s => s.ServiceName, StringComparer.OrdinalIgnoreCase))
            {
                string start;
                try { start = MapStart(svc.StartType); }
                catch { continue; }
                sb.AppendLine($"sc config \"{svc.ServiceName}\" start= {start}");
            }
        }
        catch (Exception ex)
        {
            _log.Error("Backup", "Service list failed.", ex.Message);
            return [];
        }

        var path = Path.Combine(folder, "services-restore.cmd");
        File.WriteAllText(path, sb.ToString());
        return [path];
    }

    private List<string> ExportTasks(string folder)
    {
        var sb = new StringBuilder();
        sb.AppendLine("@echo off");
        sb.AppendLine("REM Generated by PED Toolbox v3. Run as administrator.");
        try
        {
            var com = Type.GetTypeFromProgID("Schedule.Service");
            if (com is null)
            {
                _log.Warn("Backup", "Schedule.Service COM is unavailable.");
                return [];
            }

            dynamic service = Activator.CreateInstance(com)!;
            service.Connect();
            WalkTasks(service.GetFolder("\\"), sb);
        }
        catch (Exception ex)
        {
            _log.Error("Backup", "Task backup failed.", ex.Message);
            return [];
        }

        var path = Path.Combine(folder, "tasks-restore.cmd");
        File.WriteAllText(path, sb.ToString());
        return [path];
    }

    private static void WalkTasks(dynamic folder, StringBuilder sb)
    {
        foreach (var task in folder.GetTasks(0))
        {
            string path = task.Path;
            bool enabled = task.Enabled;
            var flag = enabled ? "/Enable" : "/Disable";
            sb.AppendLine($"SCHTASKS /Change /TN \"{path}\" {flag}");
        }

        foreach (var sub in folder.GetFolders(0))
            WalkTasks(sub, sb);
    }

    private List<string> ExportDrivers(string folder)
    {
        if (!AdminService.IsAdministrator())
        {
            _log.Warn("Backup", "Driver export needs administrator.");
            return [];
        }

        var dest = Path.Combine(folder, "drivers");
        Directory.CreateDirectory(dest);
        var result = _runner.Run("dism.exe", $"/online /export-driver /destination:\"{dest}\"", "Backup.Drivers", timeoutMs: 600_000);
        return result.Succeeded ? [dest] : [];
    }

    private static string MapStart(ServiceStartMode mode) => mode switch
    {
        ServiceStartMode.Automatic => "auto",
        ServiceStartMode.Manual => "demand",
        ServiceStartMode.Disabled => "disabled",
        ServiceStartMode.Boot => "boot",
        ServiceStartMode.System => "system",
        _ => "demand"
    };

    private void WriteReadme(string folder, bool fullRegistry, bool drivers)
    {
        var text = $"""
            PED Toolbox backup {DateTime.Now:u}
            SKU: {Catalog.BuildSku.Label}

            HKCU.reg                 — current user registry. Double-click to merge (you will get a UAC/regedit prompt).
            StartMenu-CloudStore.reg — Start menu layout cache (v1 equivalent).
            winKey.txt               — BackupProductKeyDefault if Windows stored one.
            services-restore.cmd     — sc config lines for current startup types. Run as admin.
            tasks-restore.cmd        — SCHTASKS enable/disable to match this snapshot. Run as admin.
            {(fullRegistry ? "HKLM/HKCR/HKU/HKCC.reg — full hives. Large. Merge only if you know why." : "Full hives were not exported. Re-run with that option if you need v1-style hive copies.")}
            {(drivers ? "drivers\\ — DISM export-driver output." : "Drivers were not exported.")}

            This is a snapshot, not a full disk image. Create a System Restore point as well.
            """;
        File.WriteAllText(Path.Combine(folder, "README.txt"), text);
    }
}

public sealed class PedBackupReport
{
    public string Folder { get; init; } = "";
    public List<string> Files { get; } = [];
}
