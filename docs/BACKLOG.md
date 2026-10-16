# Backlog — task index

**Status as of 2026-10-16**

**Id scheme:** `T0xx` and `T0xx-n` (same ids forever; never renumber or delete rows). Detail files live at `docs/tasks/<ID>.md` (filename may add a short slug).

## Pier's queue

- **T048** (`next`) — Create Microsoft Store individual account; share publisher CN for MSIX (unblocks T032-3).
- **T045** / **T046** (`deferred`) — Product/branch and power-user scope; Pier decides when/if.

Everything else below is Ped Code, Ped Release, Ped Review, or waiting on Microsoft.

| ID | Item | Priority | Status | Who acts | Detail / PR / SHA |
|---|---|---|---|---|---|
| T048 | Create Microsoft Store (Partner Center) individual account and share publisher name | High | next | Pier | [T048-store-account.md](tasks/T048-store-account.md) |
| T030 | Formal UI review of all pages | Medium | proposed | Ped Review / Ped Code | [T030-ui-review.md](tasks/T030-ui-review.md) |
| T031 | 3.1 icon, STORE_SKU, PED-Recovery | — | shipped in 3.1.0 | — | [T031-app-polish.md](tasks/T031-app-polish.md); [v3.1.0](https://github.com/PierMobayed/PEDToolBox/releases/tag/v3.1.0) |
| T032-1 | 3.2 zip → GitHub Release | — | shipped in 3.1.0 | — | [T032-1-github-release.md](tasks/T032-1-github-release.md); zip SHA256 in [HISTORY.md](HISTORY.md) |
| T032-2 | winget-pkgs PR `PED.Toolbox` — pipeline green, needs moderator | High | waiting (external: Microsoft winget moderator) | External (Microsoft) / Ped Release | [T032-2-winget-pr.md](tasks/T032-2-winget-pr.md); [winget-pkgs#442279](https://github.com/microsoft/winget-pkgs/pull/442279) |
| T032-3 | Signed MSIX → Partner Center — waiting on T048 | High | waiting (external: Pier Store account T048) | Ped Release (+ Pier for Store submit / secrets) | [T032-3-msix-partner-center.md](tasks/T032-3-msix-partner-center.md) |
| T033-1 | Smaller installer (framework-dependent or MSIX) so later winget scans stay fast | Medium | proposed | Ped Code | [T033-1-light-installer.md](tasks/T033-1-light-installer.md) |
| T033-2 | GitHub Action: automatic winget-pkgs PR on Release | Medium | proposed | Ped Code | [T033-2-winget-github-action.md](tasks/T033-2-winget-github-action.md) |
| T033-3 | In-app check for updates against GitHub Release | Medium | proposed | Ped Code | [T033-3-app-update-check.md](tasks/T033-3-app-update-check.md) |
| T040 | v1 as separate winget package `PED.run` (after Toolbox PR is merged) | Medium | proposed | Ped Release (+ Pier OK for winget-pkgs PR) | [T040-v1-winget-ped-run.md](tasks/T040-v1-winget-ped-run.md) |
| T041 | Bulgarian UI strings | Medium | proposed | Ped Code | [T041-bulgarian-ui.md](tasks/T041-bulgarian-ui.md) |
| T042 | Winget CLI `--output json` parser | Medium | proposed | Ped Code | [T042-winget-json.md](tasks/T042-winget-json.md) |
| T043 | Task Scheduler editor UI | Medium | proposed | Ped Code | [T043-task-scheduler-ui.md](tasks/T043-task-scheduler-ui.md) |
| T044 | Optional portable tools (BleachBit/Revo) — not Store | Low | deferred | Ped Code | [T044-portable-tools.md](tasks/T044-portable-tools.md) |
| T045 | Official product: default branch `v3`; keep `Tool`; `ped.run` separate | Low | deferred | Pier (decision) | [T045-default-branch.md](tasks/T045-default-branch.md) |
| T046 | Do not rush: driver packs, Wi-Fi passwords, WinRE reset, bundled cleaners | Low | deferred | Pier (decision) | [T046-deferred-power-user.md](tasks/T046-deferred-power-user.md) |
| T047 | v1 `PED.ps1` should download the bat from branch `Tool` (fix on `Tool`, not here) | Medium | proposed | Ped Code (on `Tool` branch) | [T047-v1-ps1-tool-branch.md](tasks/T047-v1-ps1-tool-branch.md) |
| T049 | Fix hardcoded 3.1.0 in `pack-release.ps1` zip name | High | next | Ped Code | [T049-pack-release-version.md](tasks/T049-pack-release-version.md) |

Finished work by version: [HISTORY.md](HISTORY.md). Roadmap phases: [ROADMAP.md](ROADMAP.md).
