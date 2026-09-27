using Microsoft.Win32;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class PrivacyService
{
    private readonly ActivityLog _log;

    public PrivacyService(ActivityLog log) => _log = log;

    public IReadOnlyList<PrivacyToggle> Read()
    {
        return
        [
            new PrivacyToggle
            {
                Id = "ads",
                Title = "Advertising ID",
                Description = "HKCU AdvertisingInfo\\Enabled. Off = 0.",
                IsEnabled = ReadDword(Registry.CurrentUser, @"SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", "Enabled", 1) == 1
            },
            new PrivacyToggle
            {
                Id = "telemetry",
                Title = "Telemetry (policy)",
                Description = "HKLM AllowTelemetry. 0/1 is more private. Requires admin. Store SKU should keep this off-by-default UI only.",
                RequiresAdmin = true,
                IsEnabled = ReadDword(Registry.LocalMachine, @"SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 3) <= 1
            },
            new PrivacyToggle
            {
                Id = "activity",
                Title = "Publish activity history",
                Description = "HKLM PublishUserActivities. 0 = do not publish. Requires admin.",
                RequiresAdmin = true,
                IsEnabled = ReadDword(Registry.LocalMachine, @"SOFTWARE\Policies\Microsoft\Windows\System", "PublishUserActivities", 1) == 1
            }
        ];
    }

    public bool Apply(PrivacyToggle toggle, bool enabled)
    {
        try
        {
            switch (toggle.Id)
            {
                case "ads":
                    WriteDword(Registry.CurrentUser, @"SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", "Enabled", enabled ? 1 : 0);
                    break;
                case "telemetry":
                    if (!AdminService.IsAdministrator()) return FailAdmin(toggle);
                    // enabled in our UI means "privacy on" i.e. telemetry limited
                    WriteDword(Registry.LocalMachine, @"SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", enabled ? 1 : 3);
                    break;
                case "activity":
                    if (!AdminService.IsAdministrator()) return FailAdmin(toggle);
                    WriteDword(Registry.LocalMachine, @"SOFTWARE\Policies\Microsoft\Windows\System", "PublishUserActivities", enabled ? 1 : 0);
                    break;
                default:
                    return false;
            }

            _log.Ok("Privacy", $"{toggle.Title} => {enabled}");
            return true;
        }
        catch (Exception ex)
        {
            _log.Error("Privacy", $"Failed {toggle.Title}", ex.Message);
            return false;
        }
    }

    private bool FailAdmin(PrivacyToggle toggle)
    {
        _log.Warn("Privacy", $"Admin required for {toggle.Title}");
        return false;
    }

    private static int ReadDword(RegistryKey hive, string path, string name, int fallback)
    {
        try
        {
            using var key = hive.OpenSubKey(path);
            if (key?.GetValue(name) is int i) return i;
            if (int.TryParse(key?.GetValue(name)?.ToString(), out var parsed)) return parsed;
        }
        catch { /* missing key */ }
        return fallback;
    }

    private static void WriteDword(RegistryKey hive, string path, string name, int value)
    {
        using var key = hive.CreateSubKey(path, true);
        key.SetValue(name, value, RegistryValueKind.DWord);
    }
}
