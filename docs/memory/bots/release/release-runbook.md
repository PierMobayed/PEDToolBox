# Ped Release — runbook

## Preconditions (release go)
- Ped Product names the version and the merge SHA on `v3`; Review approved the head SHA and CI (`.github/workflows/build.yml`) is green.

## Build
1. Work only in the main checkout (no worktrees). `git status --short` must be empty, otherwise stop and ask Product; never stash or delete Pier's files.
2. `git switch v3` then `git pull --ff-only`. Check `git diff --quiet <approved head> <merge SHA>`; if it differs, stop.
3. If `v3` is ahead of the merge SHA, `git checkout --detach <merge SHA>`, build, then switch back to `v3`.
4. Run `.\packaging\pack-release.ps1` (self-contained unless Product says otherwise). Output: `artifacts\PEDToolbox-<ver>-win-x64.zip` and `artifacts\SHA256.txt`.
5. No version bumps or repo edits. The script hardcodes `3.1.0` in the zip name; if that does not match the release version, stop and ask Product for a Code PR.
6. Status clean and back on `v3` afterwards.

## Publish
- `gh release create v<ver> --target <merge SHA>` on PierMobayed/PEDToolBox, attaching only the zip (never source).
- Notes: first line is the `/releases/download/...` URL, then the SHA-256, then one line saying the source is branch `v3`.
- Keep a local copy outside the repo in Pier's releases folder, one subfolder per version, with older zips in a backup subfolder.

## Signing
- No Authenticode certificate yet (TBD per PACKAGING.md). Store/MSIX signing waits on Pier's Partner Center account.

## winget
- Manifest URL and SHA-256 under `packaging/winget/` change only through a Code PR via Product.
- Submitting to microsoft/winget-pkgs needs Pier's explicit OK each time.

## Report
- To Ped Product: release URL, merge SHA, zip SHA-256, local copy location. Then add a run log line.

## Run log
- 2026-10-16 — Read-only PC check and fresh clone of `v3` (Pier approved). No build.
