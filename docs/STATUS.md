# Status — PED Toolbox

**Status as of 2026-10-30**

Short snapshot after task plans move + fleet rules sync (repo-rules `514a6fc`). Open work: [TASKS.md](TASKS.md). Finished releases: [HISTORY.md](HISTORY.md). Pier manual test queue: [TESTS.md](TESTS.md) (empty).

- **Branch:** `v3` = product branch; GitHub default is still `Tool` (R-8 / T045).
- **Done (merged):** [PR #11](https://github.com/PierMobayed/PEDToolBox/pull/11) — fleet docs step; T050 release folder ([PR #8](https://github.com/PierMobayed/PEDToolBox/pull/8)); [PR #13](https://github.com/PierMobayed/PEDToolBox/pull/13) — fleet docs reorg (#57) + Store pack.
- **This PR:** task detail → `docs/architecture/plans/`; `fleet.mdc` sync to repo-rules `514a6fc`; T053 release path doc; BRIEFS/CHANGELOG.
- **Now:** T049 (pack-release version); T048 Store account + listing docs; T032-2 waiting on winget moderator; T032-3 blocked on T048.
- **GitHub:** secret scanning + push protection + Dependabot enabled 2026-10-30.
- **Fleet rules:** `.repo-rules/` synced locally to repo-rules `514a6fc` (gitignored on this public repo). See `.cursor/rules/fleet.mdc`.
- Secrets map: appkeys/pedtoolbox/SECRETS-MAP.md
