using System.ServiceProcess;
using System.Text.Json;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

/// <summary>
/// Loads the v2 Service Optimizer JSON profiles (copied into Assets/Profiles) and applies
/// startup types with sc.exe. Tweaked profile is never auto-applied.
/// </summary>
public sealed class WindowsServiceOptimizer
{
    private readonly ActivityLog _log;
    private readonly ProcessRunner _runner;
    private readonly string _profilesDirectory;

    public WindowsServiceOptimizer(ActivityLog log, ProcessRunner runner, string profilesDirectory)
    {
        _log = log;
        _runner = runner;
        _profilesDirectory = profilesDirectory;
    }

    public IReadOnlyList<string> AvailableProfiles()
    {
        if (!Directory.Exists(_profilesDirectory)) return [];
        return Directory.GetFiles(_profilesDirectory, "*.json")
            .Select(Path.GetFileNameWithoutExtension)
            .Where(n => n is not null)
            .Select(n => n!)
            .OrderBy(n => n)
            .ToList();
    }

    public IReadOnlyList<WindowsServiceItem> LoadProfile(string profileName)
    {
        var path = Path.Combine(_profilesDirectory, profileName + ".json");
        if (!File.Exists(path))
        {
            _log.Error("Services", $"Profile not found: {path}");
            return [];
        }

        using var doc = JsonDocument.Parse(File.ReadAllText(path));
        var items = new List<WindowsServiceItem>();
        foreach (var group in doc.RootElement.EnumerateObject())
        {
            var display = group.Value.TryGetProperty("DisplayName", out var dn) ? dn.GetString() ?? group.Name : group.Name;
            if (!group.Value.TryGetProperty("Services", out var services)) continue;
            foreach (var svc in services.EnumerateArray())
            {
                items.Add(new WindowsServiceItem
                {
                    Group = group.Name,
                    GroupDisplay = display,
                    ServiceName = svc.GetProperty("ServiceName").GetString() ?? "",
                    DisplayName = svc.TryGetProperty("DisplayName", out var d) ? d.GetString() ?? "" : "",
                    Description = svc.TryGetProperty("Description", out var desc) ? desc.GetString() ?? "" : "",
                    DefaultStartupType = svc.TryGetProperty("DefaultStartupType", out var def) ? def.GetString() ?? "" : "",
                    ProfileStartupType = svc.TryGetProperty("ProfileStartupType", out var prof) ? prof.GetString() ?? "" : ""
                });
            }
        }

        EnrichFromSystem(items);
        return items;
    }

    public int Apply(IEnumerable<WindowsServiceItem> items, bool useProfileValue)
    {
        if (!AdminService.IsAdministrator())
        {
            _log.Warn("Services", "Administrator rights are required to change service startup types.");
            return 0;
        }

        var changed = 0;
        foreach (var item in items)
        {
            if (!item.Exists) continue;
            var target = useProfileValue ? item.ProfileStartupType : item.DefaultStartupType;
            var sc = MapStart(target);
            if (sc is null) continue;
            var result = _runner.Run("sc.exe", $"config \"{item.ServiceName}\" start= {sc}", "Services");
            if (result.Succeeded || result.ExitCode == 0)
                changed++;
        }

        _log.Ok("Services", $"Applied startup type on {changed} services.");
        return changed;
    }

    private void EnrichFromSystem(List<WindowsServiceItem> items)
    {
        Dictionary<string, ServiceController> live = [];
        try
        {
            live = ServiceController.GetServices().ToDictionary(s => s.ServiceName, StringComparer.OrdinalIgnoreCase);
        }
        catch (Exception ex)
        {
            _log.Warn("Services", "Could not enumerate services.", ex.Message);
        }

        foreach (var item in items)
        {
            if (live.TryGetValue(item.ServiceName, out var svc))
            {
                item.Exists = true;
                item.CurrentStatus = svc.Status.ToString();
                try { item.CurrentStartupType = svc.StartType.ToString(); }
                catch { item.CurrentStartupType = "?"; }
            }
            else
            {
                item.Exists = false;
                item.CurrentStatus = "Missing";
            }
        }
    }

    private static string? MapStart(string profile)
        => profile.ToLowerInvariant() switch
        {
            "automatic" or "auto" => "auto",
            "manual" or "demand" => "demand",
            "disabled" => "disabled",
            "automaticdelayedstart" or "delayed" => "delayed-auto",
            _ => null
        };
}
