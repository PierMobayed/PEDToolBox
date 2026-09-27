using System.Diagnostics;
using System.Text;
using PedToolbox.Core.Logging;
using PedToolbox.Core.Models;

namespace PedToolbox.Core.Services;

public sealed class ProcessRunner
{
    private readonly ActivityLog _log;

    public ProcessRunner(ActivityLog log) => _log = log;

    public Task<CommandResult> RunAsync(
        string fileName,
        string arguments,
        string source,
        bool useShellExecute = false,
        bool verbRunas = false,
        int timeoutMs = 120_000,
        CancellationToken cancellationToken = default)
        => Task.Run(() => Run(fileName, arguments, source, useShellExecute, verbRunas, timeoutMs), cancellationToken);

    public CommandResult Run(
        string fileName,
        string arguments,
        string source,
        bool useShellExecute = false,
        bool verbRunas = false,
        int timeoutMs = 120_000)
    {
        _log.Info(source, $"Start: {fileName} {arguments}");

        try
        {
            var psi = new ProcessStartInfo
            {
                FileName = fileName,
                Arguments = arguments,
                UseShellExecute = useShellExecute,
                Verb = verbRunas ? "runas" : "",
                CreateNoWindow = !useShellExecute,
                RedirectStandardOutput = !useShellExecute,
                RedirectStandardError = !useShellExecute
            };
            if (!useShellExecute)
            {
                psi.StandardOutputEncoding = Encoding.UTF8;
                psi.StandardErrorEncoding = Encoding.UTF8;
            }

            if (useShellExecute)
            {
                using var p = Process.Start(psi);
                if (p is null)
                {
                    _log.Error(source, "Process.Start returned null.");
                    return new CommandResult { ExitCode = -1, StandardError = "Process.Start returned null." };
                }

                if (!p.WaitForExit(timeoutMs))
                {
                    try { p.Kill(true); } catch { /* ignore */ }
                    _log.Warn(source, "Timed out.");
                    return new CommandResult { TimedOut = true, ExitCode = -2 };
                }

                _log.Ok(source, $"Exit {p.ExitCode}");
                return new CommandResult { ExitCode = p.ExitCode };
            }

            psi.RedirectStandardOutput = true;
            psi.RedirectStandardError = true;

            using var process = new Process { StartInfo = psi };
            var stdout = new StringBuilder();
            var stderr = new StringBuilder();
            process.OutputDataReceived += (_, e) => { if (e.Data != null) stdout.AppendLine(e.Data); };
            process.ErrorDataReceived += (_, e) => { if (e.Data != null) stderr.AppendLine(e.Data); };
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();

            if (!process.WaitForExit(timeoutMs))
            {
                try { process.Kill(true); } catch { /* ignore */ }
                _log.Warn(source, "Timed out.");
                return new CommandResult
                {
                    TimedOut = true,
                    ExitCode = -2,
                    StandardOutput = stdout.ToString(),
                    StandardError = stderr.ToString()
                };
            }

            process.WaitForExit();
            var result = new CommandResult
            {
                ExitCode = process.ExitCode,
                StandardOutput = stdout.ToString(),
                StandardError = stderr.ToString()
            };

            if (result.Succeeded)
                _log.Ok(source, $"Exit {result.ExitCode}");
            else
                _log.Warn(source, $"Exit {result.ExitCode}", result.CombinedOutput);

            return result;
        }
        catch (Exception ex)
        {
            _log.Error(source, ex.Message);
            return new CommandResult { ExitCode = -1, StandardError = ex.Message };
        }
    }

    public void StartDetached(string fileName, string arguments = "", bool runas = false)
    {
        _log.Info("Launcher", $"{fileName} {arguments}");
        Process.Start(new ProcessStartInfo
        {
            FileName = fileName,
            Arguments = arguments,
            UseShellExecute = true,
            Verb = runas ? "runas" : ""
        });
    }
}
