namespace PedToolbox.Core.Models;

public sealed class SystemSnapshot
{
    public string ComputerName { get; init; } = Environment.MachineName;
    public string UserName { get; init; } = Environment.UserName;
    public string OsName { get; init; } = "";
    public string OsVersion { get; init; } = "";
    public string Architecture { get; init; } = "";
    public int CpuCount { get; init; }
    public string CpuName { get; init; } = "";
    public double TotalRamGb { get; init; }
    public double AvailableRamGb { get; init; }
    public string SystemDrive { get; init; } = "";
    public double SystemDriveTotalGb { get; init; }
    public double SystemDriveFreeGb { get; init; }
    public bool Is64BitOs { get; init; }
    public bool IsAdministrator { get; init; }
    public TimeSpan Uptime { get; init; }
    public string BootTime { get; init; } = "";
}

public sealed class RestorePointInfo
{
    public string Description { get; init; } = "";
    public DateTime Created { get; init; }
    public int SequenceNumber { get; init; }
    public string RestorePointType { get; init; } = "";
}

public sealed class StartupApp
{
    public string Name { get; init; } = "";
    public string Command { get; init; } = "";
    public string Hive { get; init; } = "";
    public string KeyPath { get; init; } = "";
    public bool Enabled { get; init; } = true;
}

public sealed class InstalledApp
{
    public string DisplayName { get; init; } = "";
    public string Publisher { get; init; } = "";
    public string Version { get; init; } = "";
    public string UninstallString { get; init; } = "";
    public string ProductCode { get; init; } = "";
    public bool Is64Bit { get; init; }
}

public sealed class WingetPackage
{
    public string Id { get; init; } = "";
    public string Name { get; init; } = "";
    public string Version { get; init; } = "";
    public string Source { get; init; } = "winget";
}

public sealed class PrivacyToggle
{
    public string Id { get; init; } = "";
    public string Title { get; init; } = "";
    public string Description { get; init; } = "";
    public bool IsEnabled { get; set; }
    public bool RequiresAdmin { get; init; }
}

public sealed class WindowsServiceItem
{
    public string Group { get; init; } = "";
    public string GroupDisplay { get; init; } = "";
    public string ServiceName { get; init; } = "";
    public string DisplayName { get; init; } = "";
    public string Description { get; init; } = "";
    public string DefaultStartupType { get; init; } = "";
    public string ProfileStartupType { get; init; } = "";
    public string CurrentStartupType { get; set; } = "";
    public string CurrentStatus { get; set; } = "";
    public bool Exists { get; set; }
}

public sealed class DiskVolume
{
    public string Name { get; init; } = "";
    public string Label { get; init; } = "";
    public double TotalGb { get; init; }
    public double FreeGb { get; init; }
    public string Format { get; init; } = "";
}
