# Routines — Ped Product

**No scheduled routines and no polling, by design** (fleet rule). I act only when Pier or another bot wakes me. Manual habits, so a replacement bot can repeat them:

- On wake: `git pull` on `v3`, then HANDOFF → STATUS → DECISIONS → this folder → TASKS / BRIEFS.
- Before writing a brief: add it to `docs/BRIEFS.md`, start with the `Launched by: … Model: composer-2.5, effort low, fast off (subagents too).` header, save the UTF-8 copy to the briefs folder (see access-map).
- On a ready PR: P1 check → wait for Ped Review approval of the exact head SHA and all checks green → go to Coord by DM ([skills/p1-pre-merge-check.md](skills/p1-pre-merge-check.md)).
- After a merge: delete the head branch, fast-forward `v3` on Pier's PC; release go only for user-visible merges ([skills/post-merge-cleanup.md](skills/post-merge-cleanup.md)).
- Doc nits: collect into the next batched docs round ([skills/docs-pr-batching.md](skills/docs-pr-batching.md)).
- Session end (`/stop`): update STATUS + `/up memory` if anything changed.
