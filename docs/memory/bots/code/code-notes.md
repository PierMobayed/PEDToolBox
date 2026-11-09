# Ped Code: working notes

How to build and test, pitfalls, fragile areas. Dated lines, newest first.
Public repo: no secrets, keys, tokens, IPs or private repo URLs here.

## Build and test

- 2026-11-09: Solution: `PedToolbox.App` (WPF UI, .NET 8, Windows-only) + `PedToolbox.Core` (logic). SDK pinned by `global.json`.
- 2026-11-09: Build/test locally on Windows: `dotnet build` then `dotnet test` from the repo root. WPF does not build on Linux, so cloud Linux VMs can't run the app; prefer the Windows `laptop` worker.
- 2026-11-09: CI is `.github/workflows/build.yml`; every check must be green on the PR head before Product's go.
- 2026-11-09: Release zip comes from `packaging/pack-release.ps1` (Ped Release runs it, not Code). It hardcodes the version in the zip name; a version change needs a Code PR.
- 2026-11-09: Docs rules sync: repo-rules `scripts/sync-rules.ps1 -Only ped -Public`, verify with `-Check -Only ped -Public`.

## Pitfalls

- 2026-11-09: Private URLs (repo-rules, appkeys) must never appear in files, commit messages or PR bodies, in any commit of the branch.
- 2026-11-09: Squash merge is disabled; every commit on a PR branch lands in v3 history. Keep branches clean.
- 2026-11-09: After moving docs, grep for old relative paths and fix links in the same PR.
- 2026-11-09: Keep TASKS/BRIEFS ids unique; check the next free T-number before adding a row.
- 2026-10-18: `.repo-rules/` is gitignored; don't add it.

## Fragile areas

- 2026-11-09: Elevation: app manifest `asInvoker` vs admin-needing tools; changes here affect Store/MSIX and winget behaviour. Flag to Review.
- 2026-11-09: `packaging/winget/*.yaml` URL and SHA256 must match the published release; only change via a Product-briefed PR.
- 2026-11-09: MSIX / Partner Center (T032-3) is blocked on Pier's account; no signing cert yet (see PACKAGING.md).
- 2026-11-09: `Tool` (v1) branch is a separate tree; never merge or overwrite it from v3 work.
