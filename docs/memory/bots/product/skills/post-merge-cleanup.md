# Skill: post-merge cleanup

**When to use:** right after Coord (or I) merged a PEDToolBox PR into `v3`.

**Input:** PR number, merge SHA, head branch name, whether the change is user-visible.

**Steps:**
1. On Pier's PC (machine Shell, PowerShell): `cd C:\Pier\PEDToolBox; git push -q origin --delete <branch>`.
2. `git checkout v3; git pull --ff-only` in the same clone; confirm a clean tree at the merge SHA.
3. Next docs round: move the TASKS row to HISTORY (`- YYYY-MM-DD — <problem> — <PR link>`) and the brief from `docs/BRIEFS.md` to `docs/archive/briefs/<TASK-ID>.md`.
4. User-visible merge (bug fix, feature, performance): wake Ped Release with the version and merge SHA. Docs/internal merges: no release; they wait under Unreleased.
5. Update my memory files (`/up memory`).

**Output:** branch gone, PC clone on the new `v3`; a short note to Pier only if something failed or a release is due.

**Checks:** `git ls-remote --heads origin` no longer lists the branch; `git status` clean.
