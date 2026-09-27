using System.Management;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class RestorePointService
{
    private readonly ActivityLog _log;

    public RestorePointService(ActivityLog log) => _log = log;

    public IReadOnlyList<RestorePointInfo> List()
    {
        var list = new List<RestorePointInfo>();
        try
        {
            using var searcher = new ManagementObjectSearcher(@"\\.\root\default", "SELECT * FROM SystemRestore");
            foreach (ManagementObject obj in searcher.Get())
            {
                var desc = obj["Description"]?.ToString() ?? "";
                var seq = Convert.ToInt32(obj["SequenceNumber"] ?? 0);
                var type = obj["RestorePointType"]?.ToString() ?? "";
                DateTime created = DateTime.MinValue;
                try
                {
                    var raw = obj["CreationTime"]?.ToString();
                    if (!string.IsNullOrWhiteSpace(raw) && raw.Length >= 14)
                    {
                        created = DateTime.ParseExact(raw[..14], "yyyyMMddHHmmss", null);
                    }
                }
                catch { /* ignore parse */ }

                list.Add(new RestorePointInfo
                {
                    Description = desc,
                    SequenceNumber = seq,
                    RestorePointType = type,
                    Created = created
                });
            }
        }
        catch (Exception ex)
        {
            _log.Error("Restore", "Could not list restore points. System Restore may be off.", ex.Message);
        }

        return list.OrderByDescending(x => x.SequenceNumber).ToList();
    }

    public bool Create(string description)
    {
        if (!AdminService.IsAdministrator())
        {
            _log.Warn("Restore", "Administrator rights are required to create a restore point.");
            return false;
        }

        try
        {
            var scope = new ManagementScope(@"\\.\root\default");
            scope.Connect();
            using var sysRestore = new ManagementClass(scope, new ManagementPath("SystemRestore"), new ObjectGetOptions());
            var inParams = sysRestore.GetMethodParameters("CreateRestorePoint");
            inParams["Description"] = description;
            inParams["RestorePointType"] = 0; // APPLICATION_INSTALL
            inParams["EventType"] = 100; // BEGIN_SYSTEM_CHANGE
            var result = sysRestore.InvokeMethod("CreateRestorePoint", inParams, null);
            var code = Convert.ToInt32(result["ReturnValue"]);
            if (code == 0)
            {
                _log.Ok("Restore", $"Created restore point: {description}");
                return true;
            }

            _log.Error("Restore", $"CreateRestorePoint returned {code}");
            return false;
        }
        catch (Exception ex)
        {
            _log.Error("Restore", "Create failed.", ex.Message);
            return false;
        }
    }
}
