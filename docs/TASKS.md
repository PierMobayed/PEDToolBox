# Tasks — open index

**Status as of 2026-10-30**

**Id scheme:** `T0xx` and `T0xx-n` (same ids forever; never renumber; done/merged/shipped rows move to `docs/HISTORY.md` (date + PR; archiving, not deleting); TASKS keeps open, deferred and superseded rows only). Detail files live at `docs/guides/tasks/<ID>.md` (filename may add a short slug).

## Code priorities

Pick the next slice from the table below (Who acts = Ped Code). Suggested order:

1. **T049** — Fix hardcoded 3.1.0 in `pack-release.ps1` zip name ([T049-pack-release-version.md](guides/tasks/T049-pack-release-version.md)).
2. **T033-*** / **T041–T043** — proposed backlog when T049 is done.

Do not start T032-3 MSIX submit without Pier / Release gate. winget-pkgs PRs need Pier's explicit OK (not just Release gate). T047 stays on branch `Tool`.

## Pier's queue

- **T048** (`doing` / waiting [Pier]) — Microsoft Store individual account + publisher CN for MSIX (unblocks T032-3); Store pack docs in this PR.
- **T045** / **T046** (`deferred`) — Product/branch and power-user scope; Pier decides when/if.

Everything else below is Ped Code, Ped Release, Ped Review, or waiting on Microsoft.

| ID | Item | Priority | Status | Who acts | Detail / PR / SHA |
|---|---|---|---|---|---|
| T048 | [Pier] Create Microsoft Store (Partner Center) individual account and share publisher name | High | doing / waiting [Pier] | Pier | [T048-store-account.md](guides/tasks/T048-store-account.md) |
| T030 | [bot] Formal UI review of all pages | Medium | proposed | Ped Review / Ped Code | [T030-ui-review.md](guides/tasks/T030-ui-review.md) |
| T032-2 | [bot] winget-pkgs PR `PED.Toolbox` — pipeline green, needs moderator | High | waiting (external: Microsoft winget moderator) | External (Microsoft) / Ped Release | [T032-2-winget-pr.md](guides/tasks/T032-2-winget-pr.md); [winget-pkgs#442279](https://github.com/microsoft/winget-pkgs/pull/442279) |
| T032-3 | [bot] Signed MSIX → Partner Center — waiting on T048 | High | waiting (external: Pier Store account T048) | Ped Release (+ Pier for Store submit / secrets) | [T032-3-msix-partner-center.md](guides/tasks/T032-3-msix-partner-center.md) |
| T033-1 | [bot] Smaller installer (framework-dependent or MSIX) so later winget scans stay fast | Medium | proposed | Ped Code | [T033-1-light-installer.md](guides/tasks/T033-1-light-installer.md) |
| T033-2 | [bot] GitHub Action: automatic winget-pkgs PR on Release | Medium | proposed | Ped Code | [T033-2-winget-github-action.md](guides/tasks/T033-2-winget-github-action.md) |
| T033-3 | [bot] In-app check for updates against GitHub Release | Medium | proposed | Ped Code | [T033-3-app-update-check.md](guides/tasks/T033-3-app-update-check.md) |
| T040 | [bot] v1 as separate winget package `PED.run` (after Toolbox PR is merged) | Medium | proposed | Ped Release (+ Pier OK for winget-pkgs PR) | [T040-v1-winget-ped-run.md](guides/tasks/T040-v1-winget-ped-run.md) |
| T041 | [bot] Bulgarian UI strings | Medium | proposed | Ped Code | [T041-bulgarian-ui.md](guides/tasks/T041-bulgarian-ui.md) |
| T042 | [bot] Winget CLI `--output json` parser | Medium | proposed | Ped Code | [T042-winget-json.md](guides/tasks/T042-winget-json.md) |
| T043 | [bot] Task Scheduler editor UI | Medium | proposed | Ped Code | [T043-task-scheduler-ui.md](guides/tasks/T043-task-scheduler-ui.md) |
| T044 | [bot] Optional portable tools (BleachBit/Revo) — not Store | Low | deferred | Ped Code | [T044-portable-tools.md](guides/tasks/T044-portable-tools.md) |
| T045 | [Pier] Official product: default branch `v3`; keep `Tool`; `ped.run` separate | Low | deferred | Pier (decision) | [T045-default-branch.md](guides/tasks/T045-default-branch.md) |
| T046 | [Pier] Do not rush: driver packs, Wi-Fi passwords, WinRE reset, bundled cleaners | Low | deferred | Pier (decision) | [T046-deferred-power-user.md](guides/tasks/T046-deferred-power-user.md) |
| T047 | [bot] v1 `PED.ps1` should download the bat from branch `Tool` (fix on `Tool`, not here) | Medium | proposed | Ped Code (on `Tool` branch) | [T047-v1-ps1-tool-branch.md](guides/tasks/T047-v1-ps1-tool-branch.md) |
| T049 | [bot] Fix hardcoded 3.1.0 in `pack-release.ps1` zip name | High | next | Ped Code | [T049-pack-release-version.md](guides/tasks/T049-pack-release-version.md) |
| T051 | [bot] move v3 from .NET 8 to .NET 10 LTS (.NET 8 EOL 10 Nov 2026); in the same Code PR bump System.Management and System.ServiceProcess.ServiceController with the TFM, and add top-level `permissions: contents: read` to .github/workflows/build.yml | Medium | next | Ped Code | (backlog row only in this PR) |
| T052 | [bot] modern WinUI/Fluent look like Auto Dark Mode (winget ArminOsaj.AutoDarkMode), light/dark follows Windows | Low | proposed | Ped Code | (idea; backlog only) |

Finished work by version: [HISTORY.md](HISTORY.md). Roadmap phases: [ROADMAP.md](ROADMAP.md).
