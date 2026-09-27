# History — finished work by version

What we actually shipped and fixed. Open work is in [TASKS.md](TASKS.md). Line-level product notes: [CHANGELOG.md](CHANGELOG.md).

## 3.1.0 (2026-09-27)

| Task | What happened |
|---|---|
| Icon + Store assets | `app.ico`, MSIX logos under `packaging/msix/Assets`. |
| `STORE_SKU` | `-p:StoreSku=true` hides Services Apply. |
| PED-Recovery | HKCU, Start menu .reg, WinKey, services/tasks restore scripts; optional full hives and DISM drivers. |
| T032-1 GitHub Release | Self-contained zip `PEDToolbox-3.1.0-win-x64.zip` on [v3.1.0](https://github.com/PierMobayed/PEDToolBox/releases/tag/v3.1.0). **Zip size 57.8 MB** on GitHub. SHA256 `85997DF14A14A97D975C43D511C4D56CE2009EBDB34E6500C05A9A49BABAC35B`. Unpacked folder is larger (~140 MB class). |
| Winget id | Settled on `PED.Toolbox` (publisher prefix for later `PED.Example`). Closed earlier ids `PierMobayed.PEDToolbox` and `ped.run` as the package id. |
| T032-2 | Opened [winget-pkgs#442279](https://github.com/microsoft/winget-pkgs/pull/442279). `ped.run` URL timed out; switched to GitHub. CLA signed. **Installation Validation SUCCESS**; labels `Azure-Pipeline-Passed` + `Validation-Completed`. Waiting on a **moderator**, not a re-scan. |
| Starter | `Start-PEDToolbox.bat` for Debug (from 3.0.0, still the daily path). |
| Docs vs live | 2026-09-27 evening: TASKS/HISTORY committed; T032-2 text corrected (moderator, not hanging install scan); zip size 57.8 MB vs unpacked ~140 MB. |
| Download vs source | Binary zip URL is the user download. GitHub auto “Source code” on Releases cannot be hidden; documented in DOWNLOAD.md. |

## 3.0.0 (2026-09-27)

| Task | What happened |
|---|---|
| New tree | Folder `v3` only; v1/v2 not overwritten. Branch `v3` on `PierMobayed/PEDToolBox` (default remains `Tool`). |
| Native app | .NET 8 WPF + `PedToolbox.Core`. Pages mapped from v1 menu. |
| Docs | ANALYSIS, ARCHITECTURE, FEATURES, PACKAGING, ROADMAP, RUN. |
| Profiles | Copied Service Optimizer JSON into `Assets/Profiles`. |
