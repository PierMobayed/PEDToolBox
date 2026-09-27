# Analysis — why v3 exists

Date: 2026-09-27  
Scope: read-only review of the PED workspace, then a new tree under `v3` only.

## What is in the workspace

| Location | Role |
|---|---|
| `github/PEDToolBox` | **v1 product**. `PED-ToolBox.bat` + `PED.ps1` downloader. Version string `PED-ToolBox-1.291.2.250508`. |
| `testPedToolBox/5.lastStableVersion` | Same v1 bat + `pedDownload` assets. |
| `testPedToolBox/4.test/250508` | **v2 attempt**. .NET 6 WinForms. Parses the bat with regex and tries to show menus / run labels. Incomplete (duplicate folders 2308–0024, `PEDToolboxForm.cs` vs `Fixed.cs`). |
| `testPedToolBox/4.test/250606-guimenu` and `250608` | PowerShell WinForms buttons around the bat. Prototype, not a product. |
| `testPedToolBox/4.test/241128-Doc/01.workingOnIt/260112winServices` | Useful **v2 module**: Service Optimizer JSON profiles + PowerShell GUI. |
| `pi4.pro/ped-a1/PedBox` | Older PowerShell Studio WinForms experiment (PedBox). |

v1 README feature map (main menu): restore point, diagnostics, system check, privacy, programs (winget GUI / bloatware), startup/explorer cleanup, optimize services/tasks, junk cleaners, on/off toggles.

## Why not finish v2 in place

v2 is a **shell around a 10k-line batch file**. That is fragile (regex menus), heavy to ship (must bundle the bat + `pedDownload`), hard to certify for Store (unsigned script execution, third-party portable apps), and not a modern UI.

Finishing v2 would still leave Winget/Store with a script host, not an app.

## Why v3

- **Native** C# services instead of `call :label`.
- **Light**: .NET 8 WPF, framework-dependent publish, no WinUI/Windows App SDK runtime.
- **Looks current**: dark Fluent-like chrome, one navigation column.
- **Distributable**: `asInvoker` manifest, MSIX identity, winget YAML. Admin is opt-in via Restart.
- **Honest Store story**: service-profile Apply is marked `StoreSafe=false`. Junk tools like BleachBit are not bundled.

## What was copied (not moved)

JSON profiles from the Service Optimizer were copied to:

`v3/src/PedToolbox.App/Assets/Profiles/{default,safe,tweaked,custom}.json`

No files outside `v3` were changed.
