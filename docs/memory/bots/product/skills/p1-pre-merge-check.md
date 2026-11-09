# Skill: P1 pre-merge check

**When to use:** a Ped Code (or any) PR into `v3` is open and ready, before I give Coord the go.

**Input:** PR number; head SHA (full 40 chars); changed-file list and diff (GitHub tools, not a cloud agent).

**Steps:**
1. Confirm the PR is not a draft and targets `v3`.
2. List changed files: no removed files unless the brief says so; no binaries (zip, exe, msix, pfx, keystore).
3. Scan the diff, every commit in the branch, and the PR body for secrets, tokens, keys, IPs and private repo URLs (rules repo, keys repo, fleet-rules repo). A hit anywhere in branch history = clean re-cut (squash is disabled), not a merge commit.
4. Check `.repo-rules/` is not committed; `fleet.mdc` changes must come from the sync script (`-Check` passes).
5. If files moved: grep for the old folder name to catch broken relative links.
6. Wait for Ped Review's approval naming the exact head SHA and for all checks green (build, Cursor Approval Agent PR Router, Cursor Security Agent); "no CI" only with Pier's own words.

**Output:** a DM to Coord: PR number + full head SHA + "go, normal merge commit"; or a fix request to Ped Code.

**Checks:** a new push voids the go (recheck the new SHA); a HIGH+ security finding voids the go.
