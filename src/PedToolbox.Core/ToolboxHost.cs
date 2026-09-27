using PedToolbox.Core.Catalog;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Services;

namespace PedToolbox.Core;

/// <summary>
/// Composition root for v3 services. The WPF app constructs this once and passes it to views.
/// </summary>
public sealed class ToolboxHost
{
    public ActivityLog Log { get; }
    public ProcessRunner Runner { get; }
    public SystemInfoService SystemInfo { get; }
    public RestorePointService Restore { get; }
    public CleanupService Cleanup { get; }
    public PrivacyService Privacy { get; }
    public WingetService Winget { get; }
    public AppManagerService Apps { get; }
    public WindowsServiceOptimizer Services { get; }
    public SystemTogglesService Toggles { get; }
    public string ProfilesDirectory { get; }

    public ToolboxHost(string? profilesDirectory = null)
    {
        Log = new ActivityLog();
        Runner = new ProcessRunner(Log);
        SystemInfo = new SystemInfoService(Log);
        Restore = new RestorePointService(Log);
        Cleanup = new CleanupService(Log, Runner);
        Privacy = new PrivacyService(Log);
        Winget = new WingetService(Runner, Log);
        Apps = new AppManagerService(Log, Runner);
        Toggles = new SystemTogglesService(Runner, Log);

        ProfilesDirectory = profilesDirectory
            ?? Path.Combine(AppContext.BaseDirectory, "Assets", "Profiles");
        Services = new WindowsServiceOptimizer(Log, Runner, ProfilesDirectory);

        Log.Info("Host", $"{FeatureCatalog.AppName} {FeatureCatalog.Version} started. Admin={AdminService.IsAdministrator()}");
        Log.Info("Host", $"Profiles: {ProfilesDirectory}");
        Log.Info("Host", $"Log file: {Log.LogFilePath}");
    }
}
