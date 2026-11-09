# Status — PED Toolbox

**Status as of 2026-11-09**

Short snapshot after the per-role bot memory refresh (repo-rules docs-rules 2026-11-09). Open work: [TASKS.md](TASKS.md). Decisions: [DECISIONS.md](DECISIONS.md). Newcomer card: [HANDOFF.md](HANDOFF.md). Finished work: [HISTORY.md](HISTORY.md). Pier manual test queue: [TESTS.md](TESTS.md) (empty).

- **Version:** last release 3.1.0; docs-only changes since then sit under **Unreleased** in [CHANGELOG](releases/CHANGELOG.md). No release needed for docs merges.
- **Branch:** `v3` = product branch; GitHub default is still `Tool` (old v1; R-8 / T045).
- **Open PRs:** #16 (docs: move flat bot templates to `docs/memory/bots/templates/` + fleet map line), waiting since 2026-11-03.
- **Active briefs:** none ([BRIEFS.md](BRIEFS.md)).
- **Bot memory:** per role under `docs/memory/bots/<role>/` (product, code, review, release); each role bot writes its own folder.
- **Next (Code):** T051 move v3 from .NET 8 to .NET 10 LTS — .NET 8 end of support is 2026-11-10; no brief or PR yet. Then T049 (pack-release version) before the next release.
- **Waiting on Pier:** T048 Partner Center (Microsoft Store) individual account + publisher name, using `docs/guides/store/PIER-CHECKLIST.md`. Unblocks T032-3.
- **Waiting (external):** T032-2 winget-pkgs PR needs a Microsoft moderator.
- **GitHub:** secret scanning + push protection + Dependabot enabled 2026-10-30.
- **Fleet rules:** `.repo-rules/` synced locally to repo-rules `3d7ed95` (gitignored on this public repo). See `.cursor/rules/fleet.mdc`.
- **Do not touch:** signing keys, secrets, `.repo-rules/` in git, branch `Tool` (except T047).
- Secrets map: names and paths only, in Pier's private keys repo (appkeys), file pedtoolbox/SECRETS-MAP.md.
