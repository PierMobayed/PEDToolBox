# Open items — Ped Product

**Status as of 2026-11-09.** Open PRs and briefs, items waiting on Pier, untested items, blockers. Live task list: [docs/TASKS.md](../../../TASKS.md).

## Open PRs

- 2026-11-09 — PR #16 `docs: sync repo-rules #74 (bot memory notes)` (opened 2026-11-03, base `v3`): moves flat bot templates to `docs/memory/bots/templates/` + one `fleet.mdc` line. Not yet reviewed or merged. The product template move is already on `v3`; code/review moves still only in #16. Decide with Coord: merge or close.

## Active briefs

- 2026-11-09 — none. T054 brief archived to `docs/archive/briefs/T054.md`.

## Waiting on Pier

- 2026-10-30 — T048: create the Partner Center (Microsoft Store) individual account and share the publisher name, using `docs/guides/store/PIER-CHECKLIST.md`. Unblocks T032-3.
- Deferred, Pier decides: T045 (default branch `v3`), T046 (power-user features).

## Blockers / deadlines

- 2026-11-09 — T051 .NET 8 → .NET 10 LTS: .NET 8 end of support 2026-11-10; no brief or PR yet. One Code PR also bumps System.Management + ServiceController and adds `permissions: contents: read` to build.yml.
- 2026-10-30 — T032-2 winget-pkgs#442279 waits on a Microsoft moderator. T032-3 waits on T048.
- T049 (pack-release hardcodes 3.1.0 in the zip name) must land before the next release.

## Untested

- None in [docs/TESTS.md](../../../TESTS.md) (empty since 2026-10-18).

## Follow-ups for the next docs round

- 2026-11-09 — Local rules sync to repo-rules `3d7ed95` regenerated `.cursor/rules/fleet.mdc` (left uncommitted on Pier's PC); it needs a PR (it is outside `docs/`) or folds into #16.
- 2026-11-09 — Other roles' old flat notes still under `docs/memory/bots/` (code.md, review.md templates) — their owners migrate them (or #16 moves them).
