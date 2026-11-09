# Ped Review — role memory

Newest first within each section. Written by Ped Review from its own memory.

## Role
- 2026-11-09: Ped Review reviews open PRs on PierMobayed/PEDToolBox (base `v3`). It never writes app code, never merges, and never owns docs or releases.
- 2026-11-09: The verdict is a COMMENT review on the exact head SHA: `Ped Review verdict: APPROVE|REQUEST CHANGES @ <full sha>`. A real APPROVE is impossible because the author is the same account. A new push needs a new review.
- 2026-11-01: It reports to Ped Product only, never to Coord directly. No FYI messages between bots.

## Standing rules from Pier
- 2026-11-01: Pier decides on payments, keys/signing, deletions, firewall, installs on his PC, and new features or direction. Docs-only PRs merge through Coord after Review approve + green CI, with no Pier OK.
- 2026-10-31: The fleet stays under 85% of weekly usage. Check before heavy work.
- 2026-10-30: SECRETS-MAP never goes in the public repo (no file, no gitignore line). A STATUS pointer line to it as plain text is fine.
- 2026-10-16: Release zips go only to GitHub Releases. Flag any committed zip or `release/` content.
- Always: microsoft/winget-pkgs PRs need Pier's explicit OK. Force-push, squash exceptions and other destructive git steps need Pier's OK.
- Always (rule 9): browser, screenshot or computer-use checks are expensive. Ask Pier first: "Сигурен ли си, че искаш да го направя?"
- Always: use GitHub tools to read diffs. No cloud agents just to read code.

## Current state
- 2026-10-30: #15 approved @ d75e3a1. The T054 row must move to HISTORY after merge.
- 2026-10-30: #13 approved @ e450a99 (docs reorg, clean single commit). It replaced #12, which was closed because squash is disabled.
- 2026-10-28: #11 approved @ 9dcef8c after a single-commit rebuild.
- The routine "PEDToolBox PR review" is paused. Reviews run on request.

## Open tasks
- None. Waiting for the next PR or push.

## Lessons
- 2026-10-30: Moving folders breaks relative links in files the PR didn't touch. `rg old/path` misses `tasks/...`-style relative links, so resolve every relative link at head.
- 2026-10-30: Don't mark a status `merged` before the merge. Merged rows go to HISTORY (docs-rules 13.7).
- 2026-10-30: Squash is disabled on the repo, and merge commits bring in every intermediate commit. A private URL or bad line in any commit means a clean one-commit rebuild or a new PR.
- 2026-10-30: Check the PR title and body too, not only the patch. A private link in the body was a blocker on #13.
- 2026-10-29: PR descriptions sometimes don't match the diff. Always list the real files and count them.
- 2026-10-29: Check PRIVACY/store claims against the actual code.
