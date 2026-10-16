# Documentation rules (fleet-wide)

**Updated:** 2026-10-16 (Pier-approved via Grok Coord)

Single documentation standard for every project in Pier's Grok Bot fleet. Product owns the docs. Model: beatSmartPrice's doc set (clean files, id traceability `PREFIX-n` → PR → SHA → release, strict shipped vs unreleased) plus a short `.cursor` map (not a full alwaysApply dump of these rules).

## Files per project

- `README.md`: what it is, how to run it, links into `docs/`.
- `CHANGELOG.md`: keep an **Unreleased** section at the top. One entry per release with version/code, date, release URL and build SHA. Newest first, append-only. Each entry states its effect on open P0 risks (e.g. `R-1 unchanged`). Where there is a built artifact, record artifact SHA256 and size next to the build SHA. A bilingual (e.g. bg/en) CHANGELOG is allowed. This stays the per-release log; `docs/HISTORY.md` is a different file (moved-out / done log). Backfilled CHANGELOG entries are exempt from the release URL / SHA / not-done requirements.
- `docs/PROJECT.md`: product, audience, locked decisions (dated, with who decided).
- `docs/BACKLOG.md`: the single **open** task index (TASKS/BACKLOG — open items plus `deferred` and `superseded → ID` rows), columns ID, item, priority, status, brief/PR/SHA, plus a **Who acts** column (Pier/operator vs bot role), or the backlog split into Pier vs bot queues so Pier's to-dos are visible. Plus a `Status as of YYYY-MM-DD` line. Two-layer ids are allowed if declared at the top (e.g. `B-n` backlog item → `<PREFIX>-n` brief/implementation id). Only `done`/`merged`/`shipped` rows move to `docs/HISTORY.md` (with date and PR number) in the next docs PR; that move is archiving, not deleting rows (rule 2). Vaya's `TASKS.md` counts as its BACKLOG.
- `docs/STATUS.md`: current snapshot, max 40 lines: version, current state, open PR numbers (no head SHA), next step, blockers, and decisions waiting on Pier. No merge SHAs (they live in git/releases). No secrets, keys, or passwords. Updated inside each PR itself, reflecting the state after merge. A separate STATUS-only PR only for a Pier decision or a blocker when no other PR is in flight. **Task wrap-up** (what was decided, what remains, what not to touch) is written here at the end of each task (Pier, 2026-10-16).
- `docs/NEXT.md`: the next Code task / priorities for this project (Pier, 2026-10-16). Lives in `docs/` with STATUS, not under `.cursor`.
- `docs/HISTORY.md`: moved-out / done log, newest first. Anything dropped from STATUS, and `done`/`merged`/`shipped` rows from TASKS/BACKLOG (with date and PR number), go here briefly. Moving those rows here is archiving, not deleting (rule 2). Bots do not read HISTORY routinely, only when needed. Vaya's existing `docs/HISTORY.md` counts. CHANGELOG.md stays the per-release log. No secrets, keys, or passwords.
- `docs/ROADMAP.md`: milestones/phases with entry/exit criteria, success criteria, an owner gate, and a `Now` line. The next phase starts only after the owner (Product, and Pier where his decision is needed) reviews.
- `docs/RISKS.md`: `R-n` entries. Backlog status keys do not apply. Each entry records risk status (`open`, `accepted`, `mitigated`, `closed`), Impact and Likelihood (e.g. high/medium/low), unranked options, what it blocks, and `Decision: <owner> (pending|date)`.
- `docs/RELEASING.md`: the release runbook, no secrets.
- `docs/ARCHITECTURE.md`: optional for small repos.
- `docs/TEAM.md`: bots and people, roles, who merges and who approves.
- `docs/specs/<ID>.md`: detail for any item too big for one row. `docs/tasks/<ID>.md` is an accepted alias (pick one per project). Each detail file has sections Goal / Done / Still waiting / **Do not** (`Do not` lists scope limits for bots; required).
- `docs/archive/`: legacy or loose files move here instead of being deleted. Include `docs/archive/README.md` explaining what is there. Archive rows/ids are still never deleted.
- `.cursor/rules/fleet.mdc`: a **5–10 line map** (`alwaysApply: true`) pointing at `docs/STATUS.md`, `docs/NEXT.md`, `docs/HISTORY.md`, and **committed `.repo-rules/`** (plain-file snapshot of this rules repo; SHA in `.repo-rules/SYNCED_FROM`). It is **not** a dump of all documentation rules (Pier, 2026-10-16). Full text stays in `PierMobayed/repo-rules`. Do not gitignore `.repo-rules/`.

## Status keys

Backlog and task items (same keys in every file): `proposed`, `next`, `doing`, `merged` (unreleased), `shipped in X`, `deferred`, `superseded -> ID`, `done`, `waiting (external: X)` (blocked on an outside party: store review, Microsoft moderator, etc.).

RISKS use only: `open`, `accepted`, `mitigated`, `closed`.

## Core rules

1. Product owns the docs. Every change goes through a PR, then Review, then Product's go, then merge. Never push to `main` directly.
2. One id scheme per project (`<PREFIX>-n`). Two-layer ids are allowed if declared at the top of `BACKLOG.md` (e.g. `B-n` → `<PREFIX>-n`). Still never reuse, renumber, or delete ids or rows.
3. Same status keys in every file: `proposed`, `next`, `doing`, `merged` (unreleased), `shipped in X`, `deferred`, `superseded -> ID`, `done`, `waiting (external: X)`. RISKS use `open`, `accepted`, `mitigated`, `closed` only.
4. Nothing is "shipped" until the release evidence exists. App projects: GitHub release; record version/code, date, release URL and build SHA. Web/deploy projects (e.g. Vercel sites): production deploy URL + deployed commit SHA + date replaces the GitHub release requirement. Local apps (source: pm-bridge-system BR-23, PR #12): before installers exist, "shipped" means the merged commit SHA is pulled and running on Pier's PC at the app's path, plus the date and Product smoke evidence (Pier present for anything that starts or stops his live stack); after installers exist, "shipped" is the GitHub Release tag. Where there is a built artifact, also record artifact SHA256 and size next to the build SHA.
5. Update docs in the same PR as the change, plus a docs PR after every release. Each file keeps a dated `Status as of` line.
6. CHANGELOG is newest-first, dated and append-only (the per-release log). Keep an **Unreleased** section at the top. Each CHANGELOG entry includes what was intentionally not done, and its effect on open P0 risks (e.g. `R-1 unchanged`). A bilingual (e.g. bg/en) CHANGELOG is allowed. Backfilled CHANGELOG entries are exempt from the release URL / SHA / not-done requirements. `docs/HISTORY.md` is the moved-out / done log (also newest-first), not a second CHANGELOG.
7. Record Pier's decisions with a date in PROJECT or RISKS. Never change them without him.
8. No new loose `PLAN-*`, dated/loose `STATUS-*`, or dated `CHANGELOG-*` files; that ban does **not** apply to canonical `docs/STATUS.md`. Detail goes in `specs/<ID>.md` or the project's chosen `tasks/<ID>.md` alias. Legacy/loose files move to `docs/archive/` (with `docs/archive/README.md`); archive instead of delete. No secrets or binaries in docs.
9. Every task detail file (`docs/specs/<ID>.md` or `docs/tasks/<ID>.md`) has Goal / Done / Still waiting / **Do not**. The **Do not** section lists scope limits for bots and is required.
10. Plain language: explain each term on first use, in the project's working language.
11. ROADMAP milestones/phases have success criteria and an owner gate. The next phase starts only after the owner (Product, and Pier where his decision is needed) reviews.
12. BACKLOG has a **Who acts** column (Pier/operator vs bot role), or is split into Pier vs bot queues, so Pier's to-dos are visible.
13. STATUS, NEXT, and HISTORY:
    1. Every project keeps `docs/STATUS.md`, max 40 lines: version, current state, open PR numbers (no head SHA), next step, blockers, and decisions waiting on Pier. No merge SHAs in STATUS (they live in git/releases). Every project also keeps `docs/NEXT.md` (next Code task / priorities).
    2. STATUS.md is updated inside each PR itself, reflecting the state after merge (version, next step, blockers). At task wrap-up, write decided / remaining / do-not-touch into STATUS. A separate STATUS-only PR is only for a Pier decision or a blocker when no other PR is in flight. Never per message.
    3. Anything dropped from STATUS goes briefly into `docs/HISTORY.md`, newest first. Bots do not read HISTORY routinely, only when needed.
    4. A woken or new bot reads STATUS first and never launches a cloud agent just to gather context.
    5. No secrets, keys, or passwords in STATUS, NEXT, or HISTORY.
    6. Vaya now follows these shared docs rules like other projects. Vaya Product first checks for conflicts with Vaya's own rules (migrations, business model) and shows Pier any conflict before changing anything. The transition is a separate docs-only PR in `vaya.bg`.
    7. TASKS/BACKLOG keeps open items plus `deferred` and `superseded → ID` rows. Only `done`/`merged`/`shipped` rows move to `docs/HISTORY.md` (with date and PR number) in the next docs PR. That move is archiving, not deleting rows; it does not conflict with rule 2 (never delete rows). Vaya's `TASKS.md` counts as its BACKLOG.
    8. Stacked PRs: only the last PR to merge updates STATUS.
    9. **`.cursor` holds only a short map** pointing at `docs/STATUS.md` and `docs/NEXT.md` (and HISTORY when needed). Project memory is not stored under `.cursor/team/`.
    10. **Chat is not memory.** Cursor or Grok chat context is not fleet memory. If wrap-up never lands in git (`docs/STATUS.md`, `docs/NEXT.md`), it is lost when the chat ends or `/summarize` runs.
    11. **`docs/HISTORY.md` row format** (when archiving a solved problem): `- YYYY-MM-DD — <problem> — <link>` (link = PR, issue, or spec id). Product adds a matching HISTORY row **after** analysis when a task is done or dropped from STATUS, not instead of STATUS wrap-up.
14. A rules-file change goes in the same PR as the decision, quoting Pier.
15. Cloud agents need **only the project repo**. Rules are the committed `.repo-rules/` snapshot. Briefs still paste only the **relevant lines for this task** (model, PR or task id, what not to touch) instead of pasting this whole file. Do not attach `PierMobayed/repo-rules` as a second env repo.

## Adoption

Each project's Product bot migrates gradually through docs-only PRs. No need to rewrite history in one go; existing files can stay until folded in. Projects may be stricter than the shared rules (e.g. Vaya migrations).

## Template: `.cursor/rules/fleet.mdc` (5–10 line map)

Not `alwaysApply` with all 15 rules. Product bots can paste this (edit paths to match):

```markdown
---
description: Map to project docs and fleet rules. Do not paste full docs-rules here.
alwaysApply: true
---

# Fleet map

If the message starts with "Ти си <Роля>" (any case, including Product, Code, Review, Release, Coord, installbot), read `.repo-rules/cursor/roles/<role lowercase>.md`, then `.repo-rules/common/`, then `docs/STATUS.md`, before doing anything.

- `docs/STATUS.md` — current snapshot (read first; wrap up the task here)
- `docs/NEXT.md` — next Code task / priorities
- `docs/HISTORY.md` — done log; open a row only if the task matches
- `docs/BACKLOG.md` — open task index (Vaya: TASKS.md)
- Rules live in committed `.repo-rules/` (plain files from https://github.com/PierMobayed/repo-rules). Read `.repo-rules/cursor/roles/<role>.md` + `.repo-rules/common/`. SHA in `.repo-rules/SYNCED_FROM`. Do not gitignore `.repo-rules/`. Do not git pull in `.repo-rules/`.
```

Full documentation rules stay in this file. Per-project SETUP copy: [../cursor/SETUP.md](../cursor/SETUP.md).
