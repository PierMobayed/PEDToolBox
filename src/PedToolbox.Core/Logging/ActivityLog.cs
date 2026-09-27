namespace PedToolbox.Core.Logging;

/// <summary>
/// In-memory activity log plus an optional file under %LocalAppData%\PEDToolbox\logs.
/// Every destructive or admin action in v3 should write here so we can see what happened.
/// </summary>
public sealed class ActivityLog
{
    private readonly object _gate = new();
    private readonly List<ActivityEntry> _entries = [];
    private readonly string _logFile;

    public event EventHandler<ActivityEntry>? EntryAdded;

    public ActivityLog()
    {
        var dir = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "PEDToolbox",
            "logs");
        Directory.CreateDirectory(dir);
        _logFile = Path.Combine(dir, $"ped-{DateTime.Now:yyyyMMdd}.log");
    }

    public IReadOnlyList<ActivityEntry> Entries
    {
        get
        {
            lock (_gate) return _entries.ToList();
        }
    }

    public string LogFilePath => _logFile;

    public ActivityEntry Add(ActivityLevel level, string source, string message, string? detail = null)
    {
        var entry = new ActivityEntry
        {
            Level = level,
            Source = source,
            Message = message,
            Detail = detail
        };

        lock (_gate)
        {
            _entries.Add(entry);
            try
            {
                File.AppendAllText(_logFile, entry + (detail is null ? "" : Environment.NewLine + detail) + Environment.NewLine);
            }
            catch
            {
                // Logging must never crash the UI.
            }
        }

        EntryAdded?.Invoke(this, entry);
        return entry;
    }

    public void Info(string source, string message, string? detail = null) => Add(ActivityLevel.Info, source, message, detail);
    public void Ok(string source, string message, string? detail = null) => Add(ActivityLevel.Success, source, message, detail);
    public void Warn(string source, string message, string? detail = null) => Add(ActivityLevel.Warning, source, message, detail);
    public void Error(string source, string message, string? detail = null) => Add(ActivityLevel.Error, source, message, detail);
}
