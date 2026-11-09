# Skill: docs-PR batching

**When to use:** Review nits, rules-sync follow-ups, TASKS → HISTORY moves or brief archiving come up between rounds.

**Input:** the list of pending doc items (kept in [open-items.md](../open-items.md) under "Follow-ups for the next docs round").

**Steps:**
1. Do not open a PR per nit; add the item to open-items.
2. When a round starts (Pier/Coord ask, or a docs PR is due anyway), bundle all pending items into one medium docs-only change: a brief for Ped Code with the model line and `Launched by` header, or a direct `docs/` commit when Pier allowed it (2026-11-09 refresh).
3. Include the `/up docs` set: STATUS "Status as of", TASKS rows/markers (`[Pier]` / `[bot]`), HISTORY rows, BRIEFS → archive, TESTS.
4. Run the P1 check on the result.

**Output:** one docs PR (or one/two direct docs commits) that clears the follow-up list.

**Checks:** each file under ~400 lines; STATUS ≤ 40 lines, no merge SHAs; no private URLs or secrets in the diff.
