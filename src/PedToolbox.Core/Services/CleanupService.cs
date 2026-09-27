using Microsoft.Win32;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class CleanupService
{
    private readonly ActivityLog _log;
    private readonly ProcessRunner _runner;

    public CleanupService(ActivityLog log, ProcessRunner runner)
    {
        _log = log;
        _runner = runner;
    }

    public IReadOnlyList<StartupApp> GetStartupApps()
    {
        var apps = new List<StartupApp>();
        ReadRunKey(apps, Registry.CurrentUser, @"Software\Microsoft\Windows\CurrentVersion\Run", "HKCU");
        ReadRunKey(apps, Registry.LocalMachine, @"Software\Microsoft\Windows\CurrentVersion\Run", "HKLM");
        return apps;
    }

    public bool RemoveStartupApp(StartupApp app)
    {
        try
        {
            var hive = app.Hive == "HKLM" ? Registry.LocalMachine : Registry.CurrentUser;
            using var key = hive.OpenSubKey(app.KeyPath, writable: true);
            key?.DeleteValue(app.Name, throwOnMissingValue: false);
            _log.Ok("Startup", $"Removed {app.Hive}\\{app.Name}");
            return true;
        }
        catch (Exception ex)
        {
            _log.Error("Startup", $"Could not remove {app.Name}", ex.Message);
            return false;
        }
    }

    public CleanupReport CleanUserTemp()
    {
        var report = DeleteDirectoryContents(Path.GetTempPath(), "User TEMP");
        return report;
    }

    public CleanupReport EmptyRecycleBin()
    {
        try
        {
            // SHEmptyRecycleBin via shell — 0x00000001 = SHERB_NOCONFIRMATION
            var result = NativeMethods.SHEmptyRecycleBin(IntPtr.Zero, null, 0x00000001 | 0x00000002 | 0x00000004);
            // 0 = S_OK. Other codes (already empty, cancelled) are treated as non-fatal.
            if (result == 0)
            {
                _log.Ok("Cleanup", "Recycle Bin emptied.");
                return new CleanupReport { Label = "Recycle Bin", FilesDeleted = 0, Succeeded = true };
            }

            _log.Warn("Cleanup", $"SHEmptyRecycleBin HRESULT 0x{unchecked((uint)result):X8}");
            return new CleanupReport { Label = "Recycle Bin", Succeeded = false };
        }
        catch (Exception ex)
        {
            _log.Error("Cleanup", "Recycle Bin failed.", ex.Message);
            return new CleanupReport { Label = "Recycle Bin", Succeeded = false };
        }
    }

    public Task<CommandResult> RunDiskCleanupAsync()
        => _runner.RunAsync("cleanmgr.exe", "/d C", "DiskCleanup", useShellExecute: true);

    private void ReadRunKey(List<StartupApp> apps, RegistryKey hive, string path, string hiveName)
    {
        try
        {
            using var key = hive.OpenSubKey(path);
            if (key is null) return;
            foreach (var name in key.GetValueNames())
            {
                apps.Add(new StartupApp
                {
                    Name = name,
                    Command = key.GetValue(name)?.ToString() ?? "",
                    Hive = hiveName,
                    KeyPath = path
                });
            }
        }
        catch (Exception ex)
        {
            _log.Warn("Startup", $"Could not read {hiveName}\\{path}", ex.Message);
        }
    }

    private CleanupReport DeleteDirectoryContents(string path, string label)
    {
        var report = new CleanupReport { Label = label };
        if (!Directory.Exists(path))
        {
            _log.Warn("Cleanup", $"{label} path missing: {path}");
            return report;
        }

        foreach (var file in Directory.EnumerateFiles(path, "*", SearchOption.TopDirectoryOnly))
        {
            try
            {
                var info = new FileInfo(file);
                File.SetAttributes(file, FileAttributes.Normal);
                File.Delete(file);
                report.FilesDeleted++;
                report.BytesFreed += info.Length;
            }
            catch
            {
                report.FilesSkipped++;
            }
        }

        foreach (var dir in Directory.EnumerateDirectories(path))
        {
            try
            {
                Directory.Delete(dir, recursive: true);
                report.FilesDeleted++;
            }
            catch
            {
                report.FilesSkipped++;
            }
        }

        _log.Ok("Cleanup", $"{label}: deleted {report.FilesDeleted}, skipped {report.FilesSkipped}, freed {report.BytesFreed / 1024 / 1024} MB");
        report.Succeeded = true;
        return report;
    }

    private static class NativeMethods
    {
        [System.Runtime.InteropServices.DllImport("Shell32.dll", CharSet = System.Runtime.InteropServices.CharSet.Unicode)]
        public static extern int SHEmptyRecycleBin(IntPtr hwnd, string? pszRootPath, uint dwFlags);
    }
}

public sealed class CleanupReport
{
    public string Label { get; init; } = "";
    public int FilesDeleted { get; set; }
    public int FilesSkipped { get; set; }
    public long BytesFreed { get; set; }
    public bool Succeeded { get; set; }
}
