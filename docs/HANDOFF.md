# Handoff — PED Toolbox

**Status as of 2026-11-09.** Product on this line: **Ped Product** (docs, backlog, priorities, go/no-go). Code: Ped Code. Review: Ped Review. Release: Ped Release. Merges: Grok Coord.

1. **Read order:** `git pull` on `v3` → this file → [STATUS.md](STATUS.md) → [DECISIONS.md](DECISIONS.md) → your role folder `docs/memory/bots/<role>/` → [TASKS.md](TASKS.md) / [BRIEFS.md](BRIEFS.md) (ROADMAP / HISTORY only when needed).
2. **Product branch is `v3`.** GitHub default `Tool` is the old v1.
3. **Open blockers:** T051 .NET 10 move (.NET 8 end of support 2026-11-10); T048 Store account waits on Pier; T032-2 waits on a winget moderator; T032-3 waits on T048.
4. **Do not:** commit `.repo-rules/` or any private rules text or private repo URLs (this repo is public); put keys, passwords, tokens, IPs or security write-ups in git; push app code without a PR + Review + green CI; hand-edit `.cursor/rules/fleet.mdc` (regenerate with the sync script); launch cloud agents just to read code.
