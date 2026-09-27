namespace PedToolbox.Core.Catalog;

public sealed class FeatureItem
{
    public required string Id { get; init; }
    public required string Title { get; init; }
    public required string Description { get; init; }
    public string V1Step { get; init; } = "";
    public bool StoreSafe { get; init; } = true;
    public bool RequiresAdmin { get; init; }
}

/// <summary>
/// Maps v1 menu steps (PED-ToolBox.bat 1.291.2) onto v3 native pages.
/// v3 does not parse or execute the batch file.
/// </summary>
public static class FeatureCatalog
{
    public const string AppName = "PED Toolbox";
    public const string Version = "3.1.0";
    public const string Publisher = "PierMobayed";
    public const string SupportEmail = "pedtoolbox@gmail.com";
    public const string Website = "https://pedtoolbox.com";
    public const string GitHub = "https://github.com/PierMobayed/PEDToolBox";

    public static IReadOnlyList<FeatureItem> All { get; } =
    [
        new()
        {
            Id = "home",
            Title = "Home",
            Description = "Status, elevation, and shortcuts into the main workflows.",
            V1Step = "Main Menu",
            StoreSafe = true
        },
        new()
        {
            Id = "restore",
            Title = "Restore & backup",
            Description = "System Restore plus PED-Recovery export (registry, tasks, services, optional drivers).",
            V1Step = "Create a restore point",
            StoreSafe = true,
            RequiresAdmin = true
        },
        new()
        {
            Id = "diagnostics",
            Title = "Diagnostics",
            Description = "Hardware, disks, uptime, accounts. v1 also had boot-time test and speedtest links.",
            V1Step = "Step 0 : Test and Diagnostic",
            StoreSafe = true
        },
        new()
        {
            Id = "repair",
            Title = "Repair & updates",
            Description = "Windows Update, SFC, DISM. Commands are started only after you confirm.",
            V1Step = "Step 1 : System Check",
            StoreSafe = true,
            RequiresAdmin = true
        },
        new()
        {
            Id = "privacy",
            Title = "Privacy",
            Description = "Advertising ID, telemetry policy, activity history. Conservative defaults.",
            V1Step = "Step 2 : Privacy Settings",
            StoreSafe = true,
            RequiresAdmin = true
        },
        new()
        {
            Id = "apps",
            Title = "Apps",
            Description = "Search/install with winget, list and uninstall programs. Replaces v1 Step 3 GUI helpers.",
            V1Step = "Step 3 : Programs",
            StoreSafe = true,
            RequiresAdmin = false
        },
        new()
        {
            Id = "cleanup",
            Title = "Startup & junk",
            Description = "Startup Run keys plus temp/recycle cleanup. Disk Cleanup is optional.",
            V1Step = "Step 4 + Step 6",
            StoreSafe = true
        },
        new()
        {
            Id = "optimize",
            Title = "Services",
            Description = "Safe/Default/Tweaked profiles from the v2 Service Optimizer JSON. Not used in Store SKU apply.",
            V1Step = "Step 5 : Optimizing Programs",
            StoreSafe = false,
            RequiresAdmin = true
        },
        new()
        {
            Id = "toggles",
            Title = "System toggles",
            Description = "Hibernate, Ultimate Performance plan, indexing — with confirmations.",
            V1Step = "Step 7 : Turn on/off apps",
            StoreSafe = true,
            RequiresAdmin = true
        },
        new()
        {
            Id = "log",
            Title = "Activity log",
            Description = "What v3 actually ran, including exit codes.",
            V1Step = "n/a",
            StoreSafe = true
        },
        new()
        {
            Id = "about",
            Title = "About & ship",
            Description = "Version, license, winget and Microsoft Store packaging notes.",
            V1Step = "n/a",
            StoreSafe = true
        }
    ];

    public static IReadOnlyList<FeatureItem> ForNavigation()
        => BuildSku.IsStoreSku ? All.Where(f => f.StoreSafe).ToList() : All;
}
