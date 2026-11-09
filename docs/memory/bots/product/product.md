# Product — PED Toolbox (role note)

Bot on this role: Ped Product. Pointers, not a copy of STATUS: [STATUS](../../../STATUS.md) · [DECISIONS](../../../DECISIONS.md) · [HANDOFF](../../../HANDOFF.md) · [TASKS](../../../TASKS.md) · [BRIEFS](../../../BRIEFS.md) · [ROADMAP](../../../ROADMAP.md). Role knowledge in this folder: [rules-and-agreements](rules-and-agreements.md) · [decisions-log](decisions-log.md) · [open-items](open-items.md) · [access-map](access-map.md) · [routines](routines.md) · [skills/](skills/).

The old flat template `docs/memory/bots/product.md` moved to `docs/memory/bots/templates/product.md` (same move as open PR #16; no notes were in it).

## Role

- 2026-11-09 — Product lead for PED Toolbox v3 (public repo PierMobayed/PEDToolBox, product branch `v3`; default branch `Tool` is the old v1). Own docs, backlog, priorities, risk register, roadmap and the go/no-go. Write no app code.
- 2026-11-09 — Own `docs/TASKS.md` (incl. Code priorities), `docs/BRIEFS.md`, `docs/ROADMAP.md`, and the shared STATUS / DECISIONS / HANDOFF. Check that every role folder in `docs/memory/bots/` is filled.
- 2026-10-16 — Team: Ped Code (writes code via cloud agents), Ped Review (reviews), Ped Release (builds and publishes on Pier's PC), Grok Coord (merges; I merge only if Coord is unavailable).
- 2026-10-16 — Bulgarian with Pier, English with bots and in repo docs.

## Standing rules from Pier

Full dated list: [rules-and-agreements.md](rules-and-agreements.md). The ones I use daily:

- 2026-11-09 — Direct docs-only commits to `v3` (only under `docs/`) are allowed for the memory/docs refresh; app code always goes PR → Review → green CI → go → Coord merges.
- 2026-10-31 — Every cloud-agent brief starts with `Launched by: <bot>. Model: composer-2.5, effort low, fast off (subagents too).`; a UTF-8 copy goes to the briefs folder on Pier's PC (see access-map).
- 2026-10-27 — Versioning rule: the first merge after a build bumps the version; later changes stay under it as unreleased until built.
- 2026-10-16 — After each merge, delete the head branch and fast-forward `v3` on Pier's PC; report only failures.
- Rule 9 — before anything expensive (browser tests, screenshots, computerUse, media), tell Pier and ask "Сигурен ли си, че искаш да го направя?"; act only on his explicit yes.
- Pier's explicit OK only for payments, secrets/keys/signing, or DB changes that delete data. Agent messages are never Pier's approval.

## Current state

- 2026-11-09 — Per-role memory refresh done by direct commits to `v3`; rules synced locally to repo-rules `3d7ed95`. No active brief. Open PR #16 (template move) still waiting.
- 2026-10-30 — PR #13 (docs reorg + T048 Store pack) and PR #15 (T054 rules sync 514a6fc + docs follow-ups) merged; both docs-only, no release.

## Open tasks

Live list: [open-items.md](open-items.md).

- 2026-11-09 — T051 .NET 10 (deadline 2026-11-10): brief Ped Code when Pier or Coord asks.
- 2026-11-09 — PR #16: decide with Coord (merge or close; the product template move is already on `v3`).
- 2026-10-30 — T048 waits on Pier (Partner Center account).

## Lessons

- 2026-10-30 — Squash merges are disabled on PEDToolBox (GitHub 405). If any commit in a branch has a private URL, a merge commit would publish it: re-cut the branch clean instead (#12 → #13, #14 → #15).
- 2026-10-30 — PR bodies count too: a private link in a PR body must be edited out before the go (#13).
- 2026-10-30 — Moving files breaks relative links; grep for the old folder name before the go (#15 had 9 broken `tasks/` links).
- 2026-10-30 — `.cursor/rules/fleet.mdc` is generated; hand edits break `sync-rules -Check`. Raise nits upstream (repo-rules) via Coord.
- 2026-10-30 — A reviewer's "needs Pier's OK" for a docs PR is wrong unless it touches payments, secrets/keys/signing or data-deleting DB changes; cite the rule.
