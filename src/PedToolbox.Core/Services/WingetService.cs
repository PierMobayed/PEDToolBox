using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class WingetService
{
    private readonly ProcessRunner _runner;
    private readonly ActivityLog _log;

    public WingetService(ProcessRunner runner, ActivityLog log)
    {
        _runner = runner;
        _log = log;
    }

    public bool IsAvailable()
    {
        var result = _runner.Run("where.exe", "winget", "Winget", timeoutMs: 10_000);
        return result.Succeeded && result.StandardOutput.Contains("winget", StringComparison.OrdinalIgnoreCase);
    }

    public async Task<IReadOnlyList<WingetPackage>> SearchAsync(string query)
    {
        if (string.IsNullOrWhiteSpace(query)) return [];
        var result = await _runner.RunAsync(
            "winget",
            $"search \"{query}\" --accept-source-agreements --disable-interactivity",
            "Winget.Search",
            timeoutMs: 60_000);
        return ParseTable(result.StandardOutput);
    }

    public async Task<CommandResult> InstallAsync(string packageId)
    {
        return await _runner.RunAsync(
            "winget",
            $"install --id \"{packageId}\" -e --accept-package-agreements --accept-source-agreements --disable-interactivity",
            "Winget.Install",
            timeoutMs: 600_000);
    }

    public async Task<CommandResult> UpgradeAllAsync()
    {
        return await _runner.RunAsync(
            "winget",
            "upgrade --all --accept-package-agreements --accept-source-agreements --disable-interactivity",
            "Winget.Upgrade",
            timeoutMs: 600_000);
    }

    public async Task<IReadOnlyList<WingetPackage>> ListAsync()
    {
        var result = await _runner.RunAsync(
            "winget",
            "list --accept-source-agreements --disable-interactivity",
            "Winget.List",
            timeoutMs: 90_000);
        return ParseTable(result.StandardOutput);
    }

    private IReadOnlyList<WingetPackage> ParseTable(string output)
    {
        var packages = new List<WingetPackage>();
        var lines = output.Split(['\r', '\n'], StringSplitOptions.RemoveEmptyEntries);
        var headerIndex = Array.FindIndex(lines, l => l.Contains("Id", StringComparison.Ordinal) && l.Contains("Version", StringComparison.Ordinal));
        if (headerIndex < 0)
        {
            _log.Warn("Winget", "Could not parse winget table header.");
            return packages;
        }

        for (var i = headerIndex + 1; i < lines.Length; i++)
        {
            var line = lines[i];
            if (line.StartsWith('-') || line.StartsWith("   ")) continue;
            var parts = System.Text.RegularExpressions.Regex.Split(line.Trim(), @"\s{2,}");
            if (parts.Length < 2) continue;
            packages.Add(new WingetPackage
            {
                Name = parts[0],
                Id = parts.Length > 1 ? parts[1] : parts[0],
                Version = parts.Length > 2 ? parts[2] : "",
                Source = parts.Length > 3 ? parts[^1] : "winget"
            });
        }

        return packages;
    }
}
