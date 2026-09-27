# Changelog

Product notes. Task-level history: [HISTORY.md](HISTORY.md). Open tasks: [TASKS.md](TASKS.md).

## 3.1.0 — 2026-09-28

- Download links point at the **binary zip URL**, not the tag page. GitHub’s automatic “Source code” archives are documented as source-only ([DOWNLOAD.md](DOWNLOAD.md)).

- Winget-pkgs PR: https://github.com/microsoft/winget-pkgs/pull/442279 (`PED.Toolbox`). Pipeline green (including Installation Validation). Waiting on a moderator, not a re-scan.
- Self-contained zip **57.8 MB** on GitHub. SHA256 `85997DF14A14A97D975C43D511C4D56CE2009EBDB34E6500C05A9A49BABAC35B`

## 3.1.0 — 2026-09-27

- App icon (`Assets/app.ico`) and Microsoft Store / MSIX logos under `packaging/msix/Assets`.
- `STORE_SKU` / `-p:StoreSku=true`: hides the Services nav page and blocks profile Apply.
- PED-Recovery snapshot: HKCU, Start menu key, WinKey file, `services-restore.cmd`, `tasks-restore.cmd`; optional full hives and DISM drivers.
- `packaging/pack-release.ps1` builds a zip + SHA256. GitHub Actions builds full and Store SKUs on branch `v3`.

## 3.0.0 — 2026-09-27 (starter)

- Added `Start-PEDToolbox.bat` and `docs/RUN.md` so the app can be launched with a double-click (Debug build, not publish).

## 3.0.0 — 2026-09-27

- Created `v3` as a standalone .NET 8 WPF app (PED Toolbox).
- Documented v1 (batch) vs v2 (unfinished WinForms parser) vs v3 (native).
- Copied Service Optimizer JSON profiles into `Assets/Profiles` (read from the v2 working folder, no source edits).
- Implemented first native modules and packaging templates.
