# PED Toolbox v3

Modern native Windows 10/11 app for repair, cleanup, apps, privacy, and optional service profiles.

This folder is a **new product**. It does not wrap `PED-ToolBox.bat`. v1 and v2 files outside this folder are never overwritten.

| | |
|---|---|
| Version | 3.1.0 |
| UI | WPF (.NET 8), Fluent-style dark theme |
| Engine | `PedToolbox.Core` — WMI, registry, winget, sc.exe |
| Install | GitHub zip (self-contained, 57.8 MB) now; winget after PR merge; lighter zip later (T033-1) |
| Logs | `%LocalAppData%\PEDToolbox\logs` |

## Start (easy)

Double-click **`Start-PEDToolbox.bat`** in this folder.

It builds Debug if needed and opens the window. Details: [docs/guides/RUN.md](docs/guides/RUN.md).

**Download the app (not the source):** [PEDToolbox-3.1.0-win-x64.zip](https://github.com/PierMobayed/PEDToolBox/releases/download/v3.1.0/PEDToolbox-3.1.0-win-x64.zip) — unzip and run `PEDToolbox.exe`.

Source is optional: GitHub branch [`v3`](https://github.com/PierMobayed/PEDToolBox/tree/v3) (Code → Download ZIP). Details: [docs/guides/DOWNLOAD.md](docs/guides/DOWNLOAD.md).

## v1 vs v3

| | v1 (batch) | v3 (this app) |
|---|---|---|
| Install | `irm ped.run \| iex` | GitHub zip now; `winget install PED.Toolbox` after [winget-pkgs#442279](https://github.com/microsoft/winget-pkgs/pull/442279) merges |
| Git branch | `Tool` | `v3` |
| `ped.run` | Stays on v1 | Not used for v3 |

## Documentation

| File | What it answers |
|---|---|
| [docs/STATUS.md](docs/STATUS.md) | Current snapshot |
| [docs/TASKS.md](docs/TASKS.md) | Open tasks + Code priorities |
| [docs/guides/DOWNLOAD.md](docs/guides/DOWNLOAD.md) | App zip vs source |
| [docs/architecture/ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) | Folders, how a click becomes an action |
| [docs/guides/FEATURES.md](docs/guides/FEATURES.md) | Page-by-page behavior |
| [docs/guides/PACKAGING.md](docs/guides/PACKAGING.md) | Winget + Microsoft Store |
| [docs/guides/store/](docs/guides/store/) | Store listing pack (T048) |
| [docs/HISTORY.md](docs/HISTORY.md) | What we finished per version |
| [docs/ROADMAP.md](docs/ROADMAP.md) | High-level done vs later |
| [docs/releases/CHANGELOG.md](docs/releases/CHANGELOG.md) | Dated product notes |
| [AGENTS.md](AGENTS.md) | Agent read order |

## Rules used while building

1. Documentation lives in `v3/docs` and is updated when behavior changes.
2. All new code is only under `v3`.
3. Older trees are **read-only** sources. Service JSON profiles were copied into `src/PedToolbox.App/Assets/Profiles`.
