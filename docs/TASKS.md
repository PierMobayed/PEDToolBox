# Task list

Open and waiting work lives here. Each row has a **detail file** under `docs/tasks/`.

When a task is finished: set status to `done`, move a one-line note to [HISTORY.md](HISTORY.md), keep the detail file (mark it done at the top).

| ID | Status | Title | Detail |
|---|---|---|---|
| T030 | todo | Formal UI review of all pages | [T030-ui-review.md](tasks/T030-ui-review.md) |
| T031 | done | 3.1 icon, STORE_SKU, PED-Recovery | [T031-app-polish.md](tasks/T031-app-polish.md) |
| T032-1 | done | 3.2 zip → GitHub Release | [T032-1-github-release.md](tasks/T032-1-github-release.md) |
| T032-2 | waiting | winget-pkgs PR `PED.Toolbox` — pipeline green, needs moderator | [T032-2-winget-pr.md](tasks/T032-2-winget-pr.md) |
| T032-3 | todo | Signed MSIX → Partner Center | [T032-3-msix-partner-center.md](tasks/T032-3-msix-partner-center.md) |
| T033-1 | todo | Smaller installer (framework-dependent or MSIX) so later winget scans stay fast | [T033-1-light-installer.md](tasks/T033-1-light-installer.md) |
| T033-2 | todo | GitHub Action: automatic winget-pkgs PR on Release | [T033-2-winget-github-action.md](tasks/T033-2-winget-github-action.md) |
| T033-3 | todo | In-app check for updates against GitHub Release | [T033-3-app-update-check.md](tasks/T033-3-app-update-check.md) |
| T040 | todo | v1 as separate winget package `PED.run` (after Toolbox PR is merged) | [T040-v1-winget-ped-run.md](tasks/T040-v1-winget-ped-run.md) |
| T041 | todo | Bulgarian UI strings | [T041-bulgarian-ui.md](tasks/T041-bulgarian-ui.md) |
| T042 | todo | Winget CLI `--output json` parser | [T042-winget-json.md](tasks/T042-winget-json.md) |
| T043 | todo | Task Scheduler editor UI | [T043-task-scheduler-ui.md](tasks/T043-task-scheduler-ui.md) |
| T044 | later | Optional portable tools (BleachBit/Revo) — not Store | [T044-portable-tools.md](tasks/T044-portable-tools.md) |
| T045 | later | Official product: default branch `v3`; keep `Tool`; `ped.run` separate | [T045-default-branch.md](tasks/T045-default-branch.md) |
| T046 | later | Do not rush: driver packs, Wi-Fi passwords, WinRE reset, bundled cleaners | [T046-deferred-power-user.md](tasks/T046-deferred-power-user.md) |
| T047 | todo | v1 `PED.ps1` should download the bat from branch `Tool` (fix on `Tool`, not here) | [T047-v1-ps1-tool-branch.md](tasks/T047-v1-ps1-tool-branch.md) |

**Next to implement (after T032-2 merge, or in parallel if it stays green):** T033-1, T033-2, T033-3. T030 can run anytime. T047 is a `Tool`-branch change.

Statuses: `todo` · `waiting` (blocked on Microsoft/you) · `later` · `done`
