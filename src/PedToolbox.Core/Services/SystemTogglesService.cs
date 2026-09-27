using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class SystemTogglesService
{
    private readonly ProcessRunner _runner;
    private readonly ActivityLog _log;

    public SystemTogglesService(ProcessRunner runner, ActivityLog log)
    {
        _runner = runner;
        _log = log;
    }

    public CommandResult SetHibernate(bool enabled)
        => _runner.Run("powercfg.exe", enabled ? "/hibernate on" : "/hibernate off", "Toggle.Hibernate");

    public CommandResult EnableUltimatePerformance()
    {
        _log.Info("Toggle", "Duplicate Ultimate Performance scheme if missing, then set active.");
        _runner.Run("powercfg.exe", "-duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61", "Toggle.Power");
        return _runner.Run("powercfg.exe", "-setactive e9a42b02-d5df-448d-aa00-03f14749eb61", "Toggle.Power");
    }

    public CommandResult SetIndexing(bool enabled)
    {
        var start = enabled ? "auto" : "disabled";
        var result = _runner.Run("sc.exe", $"config WSearch start= {start}", "Toggle.Indexing");
        if (enabled)
            _runner.Run("sc.exe", "start WSearch", "Toggle.Indexing");
        else
            _runner.Run("sc.exe", "stop WSearch", "Toggle.Indexing");
        return result;
    }

    public void OpenWindowsUpdate()
        => _runner.StartDetached("ms-settings:windowsupdate");

    public void OpenWindowsSecurity()
        => _runner.StartDetached("windowsdefender:");

    public CommandResult StartSfc()
        => _runner.Run("sfc.exe", "/scannow", "Repair.SFC", useShellExecute: true, verbRunas: !AdminService.IsAdministrator(), timeoutMs: 600_000);

    public CommandResult StartDismHealth()
        => _runner.Run("dism.exe", "/Online /Cleanup-Image /RestoreHealth", "Repair.DISM", useShellExecute: true, verbRunas: !AdminService.IsAdministrator(), timeoutMs: 600_000);
}
