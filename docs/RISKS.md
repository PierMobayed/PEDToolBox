# Risks

**Status as of 2026-10-12**

Risks use ids `R-n`. **Impact** and **Likelihood** are rough (high / medium / low). **Decision** records who owns the call and whether it is still pending or dated.

## R-1 — No paid code-signing certificate

- **Status:** accepted
- **Impact:** medium (Store and some enterprise policies expect signed installers)
- **Likelihood:** high until Store path ships
- **Options (not ranked):** buy an Authenticode cert; sign only via Microsoft Store after upload; delay MSIX/Store
- **Blocks:** [T032-3](tasks/T032-3-msix-partner-center.md) (signed MSIX → Partner Center)
- **Waiting on:** Pier creating the Partner Center account (**T048**) and sharing the Store publisher name
- **Decision:** Pier, 2026-10-12 — ship via the free Microsoft Store individual account and **MSIX** (Microsoft’s packaged app format); Microsoft re-signs after certification; no paid cert for now

## R-2 — Winget catalog PR stuck on external review

- **Status:** open
- **Impact:** medium (`winget install PED.Toolbox` unavailable until the community repo accepts the manifest)
- **Likelihood:** medium (pipeline already passed; human moderator step remains)
- **Options (not ranked):** wait for merge; withdraw and resubmit if moderator requests changes; nudge via winget-pkgs process only
- **Blocks:** [T040](tasks/T040-v1-winget-ped-run.md) (separate `PED.run` winget package must not race the first `PED.Toolbox` entry)
- **Waiting on:** Microsoft winget-pkgs moderator for [PR #442279](https://github.com/microsoft/winget-pkgs/pull/442279) (`PED.Toolbox`, validated)
- **Decision:** Pier (pending)

## R-3 — Release zip name hardcoded to 3.1.0

- **Status:** open
- **Impact:** high for the next release (wrong artifact name, wrong winget YAML, broken download links)
- **Likelihood:** high if anyone runs `pack-release.ps1` without fixing it
- **Options (not ranked):** read version from `Directory.Build.props` or a single manifest; parameterize `pack-release.ps1`
- **Blocks:** next GitHub Release and any winget manifest update tied to that build (**T049**)
- **Evidence:** `packaging/pack-release.ps1` sets `PEDToolbox-3.1.0-…` in the zip file name
- **Decision:** Pier (pending)

## R-4 — Self-contained zip is large

- **Status:** open
- **Impact:** medium (slower **winget** — Windows’ command-line package manager — validation; larger downloads)
- **Likelihood:** high for every new winget version while the default artifact stays self-contained
- **Options (not ranked):** framework-dependent zip plus .NET 8 Desktop Runtime; MSIX; keep self-contained only as an optional GitHub asset
- **Blocks:** fast iteration on [T033-1](tasks/T033-1-light-installer.md) (smaller default installer)
- **Evidence:** 3.1.0 zip **57.8 MB** on GitHub; unpacked ~140 MB ([HISTORY.md](HISTORY.md), [PACKAGING.md](PACKAGING.md))
- **Decision:** Pier (pending)
