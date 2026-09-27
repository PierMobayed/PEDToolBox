# Architecture

## Daily start

Double-click `Start-PEDToolbox.bat` in the v3 root. See `docs/RUN.md`.

## Projects

```
v3/
  PedToolbox.sln
  src/PedToolbox.Core     class library, Windows APIs
  src/PedToolbox.App      WPF UI (assembly name PEDToolbox)
  packaging/              publish + winget + msix templates
  docs/                   this documentation
                  TASKS.md + tasks/*.md (work items)
                  HISTORY.md (finished work per version)
```

## Runtime composition

`App` creates a single `ToolboxHost` on startup.

```
click in a View
  -> Host.<Service>.Method()
    -> ProcessRunner / Registry / WMI / ServiceController
      -> ActivityLog (memory + %LocalAppData%\PEDToolbox\logs\ped-YYYYMMDD.log)
```

Views are UserControls swapped into `MainWindow.PageHost`. There is no navigation framework package.

## Elevation

`app.manifest` requests `asInvoker` so the Store/MSIX identity stays a normal desktop app.

`AdminService.RelaunchElevated` uses `Verb=runas` on the same EXE. Individual tools (SFC/DISM) may also prompt if the process is not admin.

## Data

| Kind | Where |
|---|---|
| Service profiles | `Assets/Profiles/*.json` copied to output |
| Activity log | `%LocalAppData%\PEDToolbox\logs` |
| No telemetry | v3 does not phone home |

## Feature catalog

`FeatureCatalog` is the map from v1 step names to v3 page ids. Adding a page means: catalog entry, UserControl, `MainWindow.CreatePage` case.

## Packaging split

| Artifact | Why |
|---|---|
| Framework-dependent win-x64 | Smallest. User needs .NET 8 Desktop Runtime. Best for Store if you rely on framework packages, or for testers who already have the runtime. |
| Self-contained | Larger, no runtime. **3.1.0 GitHub zip** is this (57.8 MB compressed). |
| MSIX | Store + `winget` installerType msix. Needs a signing certificate. |
