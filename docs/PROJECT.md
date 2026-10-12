# Project — PED Toolbox v3

**Status as of 2026-10-12**

## What this is

**PED Toolbox v3** is a native **.NET 8 WPF** Windows maintenance app: repair, cleanup, apps (winget), privacy, services, and related tools in one desktop UI. It is the successor to the **v1 batch toolbox** (`PED-ToolBox.bat` on GitHub branch **`Tool`**), built as a new tree under folder `v3` without wrapping the bat file.

Current shipped line: **3.1.0** (self-contained GitHub zip). Open work: [BACKLOG.md](BACKLOG.md). Roadmap: [ROADMAP.md](ROADMAP.md).

## Audience

- **Windows 10/11 users** who want a maintained, clickable toolbox (not a script menu).
- **Pier and Ped bots** (Code, Release, Review, Product) who ship builds, docs, and store/winget channels.
- **Power users** who may still use v1 via `ped.run` until separate packaging (T040) exists.

## Branches and channels

| Branch / channel | Role |
|---|---|
| **`v3`** | Product branch for the WPF app, docs, and releases of v3.x. |
| **`Tool`** | Repo default today; **v1** batch product only. Fixes like T047 happen here, not by overwriting from `v3`. |
| **`ped.run`** | Separate one-liner install for **v1**; not the v3 download path. Winget id for v3 is **`PED.Toolbox`**, not the domain. |

## Locked decisions

Copy for traceability; do not change without Pier.

**Decision: Pier, 2026-10-12** — Ped will be signed through a free Microsoft Store individual developer account using MSIX. Microsoft re-signs the package after certification, so there is no SmartScreen warning on the Store package. No paid code-signing certificate for now. Next step: Pier creates the Partner Center account and shares the publisher name for the MSIX manifest (T048). That unblocks T032-3. After the app is in the Store, winget can also point at the `msstore` source. (Full text: [PACKAGING.md](PACKAGING.md) § Signing.)

**Decision: Pier, 2026-10-11** — Ped releases now run on Pier's PC through machine Shell, done by the Ped Release bot (same as naChas). The bridge and local Cursor are no longer used for releases. Known release blockers to plan as code tasks include hardcoded 3.1.0 in `pack-release.ps1` (T049); signing for GitHub zip/winget stays unsigned for now, with Store MSIX as the signed path above. (Full text: [PACKAGING.md](PACKAGING.md) § Signing and [RELEASING.md](RELEASING.md).)

**Recorded with 3.1.0 ship (2026-09-27)** — Community winget package id is **`PED.Toolbox`** (publisher prefix for later packages such as `PED.Example`). Earlier ids `PierMobayed.PEDToolbox` and using **`ped.run`** as the package id were closed. See [HISTORY.md](HISTORY.md) § 3.1.0.
