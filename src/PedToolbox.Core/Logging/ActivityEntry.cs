namespace PedToolbox.Core.Logging;

public enum ActivityLevel
{
    Info,
    Success,
    Warning,
    Error
}

public sealed class ActivityEntry
{
    public DateTime Timestamp { get; init; } = DateTime.Now;
    public ActivityLevel Level { get; init; }
    public string Source { get; init; } = "";
    public string Message { get; init; } = "";
    public string? Detail { get; init; }

    public override string ToString()
        => $"[{Timestamp:HH:mm:ss}] {Level,-7} {Source}: {Message}";
}
