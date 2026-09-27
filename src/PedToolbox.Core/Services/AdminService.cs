using System.Diagnostics;
using System.Security.Principal;

namespace PedToolbox.Core.Services;

public static class AdminService
{
    public static bool IsAdministrator()
    {
        using var identity = WindowsIdentity.GetCurrent();
        var principal = new WindowsPrincipal(identity);
        return principal.IsInRole(WindowsBuiltInRole.Administrator);
    }

    /// <summary>
    /// Relaunches the current EXE with a UAC prompt. Returns false if the user cancelled.
    /// </summary>
    public static bool RelaunchElevated(string? extraArgs = null)
    {
        var exe = Environment.ProcessPath;
        if (string.IsNullOrWhiteSpace(exe))
            return false;

        try
        {
            var start = new ProcessStartInfo
            {
                FileName = exe,
                UseShellExecute = true,
                Verb = "runas",
                Arguments = extraArgs ?? ""
            };
            Process.Start(start);
            return true;
        }
        catch
        {
            return false;
        }
    }
}
