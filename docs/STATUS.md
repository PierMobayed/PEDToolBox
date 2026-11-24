# Status — PED Toolbox

**Status as of 2026-11-24**

Short snapshot. Open work: [TASKS.md](TASKS.md). Decisions: [DECISIONS.md](DECISIONS.md). Newcomer card: [HANDOFF.md](HANDOFF.md). Finished work: [HISTORY.md](HISTORY.md). Pier manual test queue: [TESTS.md](TESTS.md) (empty). Project work is paused (docs only) until Pier resumes.

- **Version:** last release 3.1.0; docs-only changes since then sit under **Unreleased** in [CHANGELOG](releases/CHANGELOG.md). No release needed for docs merges.
- **Branch:** `v3` = product branch; GitHub default is still `Tool` (old v1; R-8 / T045).
- **Open PRs:** none (#16 closed unmerged; #18–#20 merged 2026-11-24; #17 merged 2026-11-11).
- **Active briefs:** none ([BRIEFS.md](BRIEFS.md)).
- **Bot memory:** moved on 2026-11-24 to the private repo testPedToolBox, branch `bot-memory` (role folders `docs/memory/bots/<role>/` there); no longer in this public repo.
- **Next (when Pier resumes project work):** T051 move v3 from .NET 8 to .NET 10 LTS — .NET 8 end of support is 2026-11-10; no brief or PR yet. Then T049 (pack-release version) before the next release. T055 (move project to the private repo, branch `main`) is planned; scope TBD.
- **Waiting on Pier:** T048 Partner Center (Microsoft Store) individual account + publisher name, using `docs/guides/store/PIER-CHECKLIST.md`. Unblocks T032-3.
- **Waiting (external):** winget-pkgs #442271 `PED.CpuThermometar` 0.1.0 waits on a Microsoft moderator. T032-2 (`PED.Toolbox`; old #442279 closed stale 2026-11-16) is todo after that passes, and needs Pier's explicit OK.
- **GitHub:** secret scanning + push protection + Dependabot enabled 2026-10-30.
- **Fleet rules:** `.repo-rules/` synced locally to repo-rules `3d7ed95` (gitignored on this public repo). See `.cursor/rules/fleet.mdc`.
- **Do not touch:** signing keys, secrets, `.repo-rules/` in git, branch `Tool` (except T047).
- Secrets map: names and paths only, in Pier's private keys repo (appkeys), file pedtoolbox/SECRETS-MAP.md.
