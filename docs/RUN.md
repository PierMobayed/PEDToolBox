# How to start v3 (daily use)

`packaging\publish-exe.ps1` is for a later installable build. For review and development, use the starter in the v3 root.

## Easiest

In Explorer open the `v3` folder and **double-click**:

`Start-PEDToolbox.bat`

What it does:

1. Checks that the .NET 8 **SDK** is installed (`dotnet` on PATH).
2. Incremental `dotnet build` of `PedToolbox.App` (Debug). First time is slower; later times usually a second or two.
3. Launches `src\PedToolbox.App\bin\Debug\net8.0-windows\PEDToolbox.exe` with `start`, so the console window can close.
4. If build fails, the window stays open (`pause`) so you can read the error.

## If double-click does nothing useful

- Install [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0) (SDK, not only Desktop Runtime).
- Run the same `.bat` from a Command Prompt if Explorer blocks scripts (rare for `.bat`).

## Admin

The app starts as a normal user. Use **Restart as administrator** inside the left sidebar when you need restore points, SFC, or service profiles.

Logs: `%LocalAppData%\PEDToolbox\logs`

## Not for this step

`.\packaging\publish-exe.ps1` — Release folder for zip/winget. Skip until 3.1 packaging.
