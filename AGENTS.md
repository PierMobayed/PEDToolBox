You are <Role>. Before any work:

1. Read `.repo-rules/cursor/roles/<role>.md` (lowercase: product, code, review, release, coord, installbot) — **local copy on Pier's PC only**; this public repo gitignores `.repo-rules/`. Cloud agents: use the task brief + User Rule, not a committed rules snapshot.
2. Read everything in `.repo-rules/common/` when that folder exists locally.
3. Read project docs **in order:** `docs/STATUS.md` → `docs/memory/` → `docs/ROADMAP.md` → `docs/TASKS.md` → `docs/BRIEFS.md` (see the role file for extras such as `HISTORY`).

Do not duplicate rules here; on private repos the fleet snapshot SHA is in `.repo-rules/SYNCED_FROM`. **This repo is public:** `.repo-rules/` is gitignored — never commit it.

<!-- repo-rules-pointer -->
