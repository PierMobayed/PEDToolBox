# Merge rule

**Updated:** 2026-10-16 (Pier-approved via Grok Coord)  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

Applies to every project in the fleet: naChas/beatSmartPrice, Vaya, Liko TV, PED Toolbox, SetupAI, VesiTV/tv1, **pm-bridge-system**.

**Who merges:** Grok Coord is the **first choice** for merging PRs. The project's **Product bot** is the **second choice**, used only if Coord is unavailable. Code and Review never merge.

**Always a PR.** Never commit or push to `main` directly (Cursor Code / Review / Product / Coord included).

**Preconditions:**
1. Review approves the latest head SHA
2. CI is green on that head
3. Product gives the go naming the PR number and head SHA

The PR must not be a draft — no draft PRs get merged.

A COMMENT review or a channel OK counts as approval only if it names the **full** head SHA (40 characters).

**CI green** means every check run passed. If a repo has no CI, the Product go must say `no CI`.

A new head SHA or any HIGH+ finding voids the go and the Review approval. (The Vessy agent `bc-af7a996c` exception in [models-and-usage.md](./models-and-usage.md) Exceptions applies to this voiding rule too.)

**Method:** Squash-merge pinned to the head SHA where squash-merge is allowed; otherwise a merge commit (e.g. Ped). Then post the merge SHA in the project room.

**After merge - branch cleanup (Pier-approved 2026-10-16, all projects):** the project's Product bot deletes the merged head branch on GitHub and locally on Pier's PC (`git fetch --prune`, then `git branch -d` for merged local branches). Branches of open PRs are kept. Each repo should also have the GitHub setting 'Automatically delete head branches' turned on (Pier sets it).

**How (GitHub tools can't delete branches):** use machine Shell on Pier's PC (machineId `9b82298f-0302-4908-adee-e37947e1635b`): `cd C:\Pier\<project>; git push -q origin --delete <branch>; git fetch --prune`. If Auto-review blocks it, retry the same command with the approval flag and the block reason. Do it quietly right after the merge; report only on failure, never ask the group.

**Needs Pier's explicit OK in DM:** anything touching payments (e.g. Stripe), secrets or keys or signing, or DB changes that delete data.

**Auto-deploy projects (e.g. Vaya on Vercel):** Product checks the live site after each merge. Vaya live check = Vercel status green + HTTP 200.

**main is unprotected (R-3).** Review bots flag commits that landed on `main` without a PR.

Grok wake chain (who talks to whom) lives in [../grok/wake-rules.md](../grok/wake-rules.md). Cursor subagent order lives in [../cursor/roles/coord.md](../cursor/roles/coord.md).
