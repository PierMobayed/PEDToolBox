using System.Management;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class SystemInfoService
{
    private readonly ActivityLog _log;

    public SystemInfoService(ActivityLog log) => _log = log;

    public SystemSnapshot Capture()
    {
        var drive = new DriveInfo(Path.GetPathRoot(Environment.SystemDirectory) ?? "C:\\");
        var tick = Environment.TickCount64;
        var uptime = TimeSpan.FromMilliseconds(tick);

        var snap = new SystemSnapshot
        {
            OsName = ReadCim("Win32_OperatingSystem", "Caption") ?? Environment.OSVersion.ToString(),
            OsVersion = ReadCim("Win32_OperatingSystem", "Version") ?? Environment.OSVersion.Version.ToString(),
            Architecture = Environment.Is64BitOperatingSystem ? "x64" : "x86",
            CpuCount = Environment.ProcessorCount,
            CpuName = (ReadCim("Win32_Processor", "Name") ?? "").Trim(),
            TotalRamGb = Math.Round(GetTotalRamBytes() / 1024d / 1024d / 1024d, 1),
            AvailableRamGb = Math.Round(GetAvailableRamBytes() / 1024d / 1024d / 1024d, 1),
            SystemDrive = drive.Name,
            SystemDriveTotalGb = Math.Round(drive.TotalSize / 1024d / 1024d / 1024d, 1),
            SystemDriveFreeGb = Math.Round(drive.AvailableFreeSpace / 1024d / 1024d / 1024d, 1),
            Is64BitOs = Environment.Is64BitOperatingSystem,
            IsAdministrator = AdminService.IsAdministrator(),
            Uptime = uptime,
            BootTime = (DateTime.Now - uptime).ToString("g")
        };

        _log.Info("SystemInfo", $"Captured {snap.OsName} / {snap.CpuName}");
        return snap;
    }

    public IReadOnlyList<DiskVolume> GetVolumes()
    {
        var list = new List<DiskVolume>();
        foreach (var d in DriveInfo.GetDrives().Where(x => x.IsReady && x.DriveType == DriveType.Fixed))
        {
            list.Add(new DiskVolume
            {
                Name = d.Name,
                Label = d.VolumeLabel,
                TotalGb = Math.Round(d.TotalSize / 1024d / 1024d / 1024d, 1),
                FreeGb = Math.Round(d.AvailableFreeSpace / 1024d / 1024d / 1024d, 1),
                Format = d.DriveFormat
            });
        }
        return list;
    }

    private static string? ReadCim(string className, string property)
    {
        try
        {
            using var searcher = new ManagementObjectSearcher($"SELECT {property} FROM {className}");
            foreach (var obj in searcher.Get())
            {
                return obj[property]?.ToString();
            }
        }
        catch
        {
            // WMI can be disabled; callers already have OSVersion fallbacks.
        }

        return null;
    }

    private static ulong GetTotalRamBytes()
    {
        try
        {
            using var searcher = new ManagementObjectSearcher("SELECT TotalVisibleMemorySize FROM Win32_OperatingSystem");
            foreach (var obj in searcher.Get())
            {
                if (obj["TotalVisibleMemorySize"] is ulong kb) return kb * 1024;
                if (ulong.TryParse(obj["TotalVisibleMemorySize"]?.ToString(), out var parsed)) return parsed * 1024;
            }
        }
        catch { /* fallback */ }

        return (ulong)GC.GetGCMemoryInfo().TotalAvailableMemoryBytes;
    }

    private static ulong GetAvailableRamBytes()
    {
        try
        {
            using var searcher = new ManagementObjectSearcher("SELECT FreePhysicalMemory FROM Win32_OperatingSystem");
            foreach (var obj in searcher.Get())
            {
                if (obj["FreePhysicalMemory"] is ulong kb) return kb * 1024;
                if (ulong.TryParse(obj["FreePhysicalMemory"]?.ToString(), out var parsed)) return parsed * 1024;
            }
        }
        catch { /* fallback */ }

        return 0;
    }
}
