# PED Toolbox v3

Modern native Windows 10/11 app for repair, cleanup, apps, privacy, and optional service profiles.

This folder is a **new product**. It does not wrap `PED-ToolBox.bat`. v1 and v2 files outside this folder are never overwritten.

| | |
|---|---|
| Version | 3.0.0 |
| UI | WPF (.NET 8), Fluent-style dark theme |
| Engine | `PedToolbox.Core` — WMI, registry, winget, sc.exe |
| Install | framework-dependent EXE (light) or MSIX |
| Logs | `%LocalAppData%\PEDToolbox\logs` |

## Start (easy)

Double-click **`Start-PEDToolbox.bat`** in this folder.

It builds Debug if needed and opens the window. Details: [docs/RUN.md](docs/RUN.md).

Publish/zip (`packaging\publish-exe.ps1`) is a later step, not required to try the app.

## Documentation

| File | What it answers |
|---|---|
| [docs/ANALYSIS.md](docs/ANALYSIS.md) | What v1 and v2 were, why v3 |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Folders, how a click becomes an action |
| [docs/FEATURES.md](docs/FEATURES.md) | Page-by-page behavior |
| [docs/PACKAGING.md](docs/PACKAGING.md) | Winget + Microsoft Store |
| [docs/ROADMAP.md](docs/ROADMAP.md) | What is in 3.0.0 vs later |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Dated changes in v3 |

## Rules used while building

1. Documentation lives in `v3/docs` and is updated when behavior changes.
2. All new code is only under `v3`.
3. Older trees are **read-only** sources. Service JSON profiles were copied into `src/PedToolbox.App/Assets/Profiles`.
