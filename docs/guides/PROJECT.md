# Project — PED Toolbox v3

**Status as of 2026-10-12**

## What this is

**PED Toolbox v3** is a native **.NET 8 WPF** Windows maintenance app: repair, cleanup, apps (winget), privacy, services, and related tools in one desktop UI. It is the successor to the **v1 batch toolbox** (`PED-ToolBox.bat` on GitHub branch **`Tool`**), built as a new tree under folder `v3` without wrapping the bat file.

Current shipped line: **3.1.0** (self-contained GitHub zip). Open work: [TASKS.md](../TASKS.md). Roadmap: [ROADMAP.md](../ROADMAP.md).

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

### Decision: Pier, 2026-10-12

> **Decision: Pier, 2026-10-12** — Ped will be signed through a free Microsoft Store individual developer account using MSIX. Microsoft re-signs the package after certification, so there is no SmartScreen warning. No paid code-signing certificate for now. Next step: Pier creates the Partner Center account at [storedeveloper.microsoft.com](https://storedeveloper.microsoft.com) (free for individuals, needs ID + selfie) and shares the publisher name for the MSIX manifest (T048). That unblocks T032-3 (signed MSIX to Partner Center). After the app is in the Store, winget can also point at the `msstore` source.

Source: [PACKAGING.md](PACKAGING.md) (§ Signing → Decisions)

### Decision: Pier, 2026-10-11

> **Decision: Pier, 2026-10-11** — Ped releases now run on Pier's PC through machine Shell, done by the Ped Release bot (same as naChas). The bridge and local Cursor are no longer used for releases. Known release blockers to plan later as code tasks: `pack-release.ps1` hardcodes 3.1.0 in the zip name (T049); no signing cert (now resolved by the Store route above).

Source: [PACKAGING.md](PACKAGING.md) (§ Signing → Decisions)

### Recorded in HISTORY 3.1.0

> Settled on `PED.Toolbox` (publisher prefix for later `PED.Example`). Closed earlier ids `PierMobayed.PEDToolbox` and `ped.run` as the package id.

Source: [HISTORY.md](HISTORY.md) (§ 3.1.0, Winget id row)
