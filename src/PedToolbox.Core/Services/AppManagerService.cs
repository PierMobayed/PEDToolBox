using Microsoft.Win32;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class AppManagerService
{
    private readonly ActivityLog _log;
    private readonly ProcessRunner _runner;

    public AppManagerService(ActivityLog log, ProcessRunner runner)
    {
        _log = log;
        _runner = runner;
    }

    public IReadOnlyList<InstalledApp> ListInstalled()
    {
        var apps = new Dictionary<string, InstalledApp>(StringComparer.OrdinalIgnoreCase);
        ReadUninstall(apps, Registry.LocalMachine, @"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", true);
        ReadUninstall(apps, Registry.LocalMachine, @"SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall", false);
        ReadUninstall(apps, Registry.CurrentUser, @"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", false);
        return apps.Values.OrderBy(a => a.DisplayName).ToList();
    }

    public CommandResult Uninstall(InstalledApp app)
    {
        if (string.IsNullOrWhiteSpace(app.UninstallString))
        {
            _log.Warn("Apps", $"No uninstall string for {app.DisplayName}");
            return new CommandResult { ExitCode = -1, StandardError = "No uninstall string." };
        }

        var cmd = app.UninstallString.Trim();
        string file;
        string args;
        if (cmd.StartsWith('"'))
        {
            var end = cmd.IndexOf('"', 1);
            file = cmd[1..end];
            args = cmd[(end + 1)..].Trim();
        }
        else
        {
            var space = cmd.IndexOf(' ');
            if (space < 0)
            {
                file = cmd;
                args = "";
            }
            else
            {
                file = cmd[..space];
                args = cmd[(space + 1)..];
            }
        }

        _log.Info("Apps", $"Uninstall {app.DisplayName}");
        return _runner.Run(file, args, "Apps.Uninstall", useShellExecute: true, timeoutMs: 300_000);
    }

    private static void ReadUninstall(Dictionary<string, InstalledApp> apps, RegistryKey hive, string path, bool is64)
    {
        try
        {
            using var root = hive.OpenSubKey(path);
            if (root is null) return;
            foreach (var subName in root.GetSubKeyNames())
            {
                using var sub = root.OpenSubKey(subName);
                if (sub is null) continue;
                if (sub.GetValue("SystemComponent") is int sc && sc == 1) continue;
                var name = sub.GetValue("DisplayName")?.ToString();
                if (string.IsNullOrWhiteSpace(name)) continue;
                if (!apps.ContainsKey(name))
                {
                    apps[name] = new InstalledApp
                    {
                        DisplayName = name,
                        Publisher = sub.GetValue("Publisher")?.ToString() ?? "",
                        Version = sub.GetValue("DisplayVersion")?.ToString() ?? "",
                        UninstallString = sub.GetValue("UninstallString")?.ToString() ?? "",
                        ProductCode = subName,
                        Is64Bit = is64
                    };
                }
            }
        }
        catch
        {
            // Some uninstall keys are not readable.
        }
    }
}
