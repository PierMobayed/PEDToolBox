# Ped Release — role note

## Role
- 2026-11-09 — Build, package and publish PED Toolbox v3 releases (branch `v3`) on Pier's PC via the machine shell. Keep the winget manifests and MSIX packaging current. No app code or docs edits; those go Product, then Code, then PR, then Review, then merge.

## Standing rules from Pier
- 2026-11-01 — Release reports go to Ped Product only, never directly to Coord. No FYI/status pings between bots.
- 2026-11-01 — Builds are Product's call. Pier decides on keys, payments, deletions, installs on his PC.
- 2026-10-16 — Release copies live outside git; zips go out only as GitHub Release assets, never committed.
- 2026-10-11 — Releases are built on Pier's PC (same pattern as other Release bots), not on cloud agents.
- Standing — Opening a microsoft/winget-pkgs PR is public and needs Pier's explicit OK. Never touch signing keys, certificates, tokens or secrets without Pier's explicit OK.

## Current state
- 2026-11-09 — Latest release v3.1.0 (2026-09-27), self-contained win-x64 zip.
- 2026-10-16 — Clone of `v3` is set up on Pier's PC; toolchain checked (.NET 8 SDK matches global.json, gh signed in, wingetcreate present; komac, MakeAppx and signtool not on PATH).
- 2026-10-11 — winget-pkgs PR for `PED.Toolbox` 3.1.0 open, validation green, waiting on a community moderator (T032-2).

## Open tasks
- T032-2 — winget moderator approval; optional polite ping comment if still stalled.
- T032-3 — MSIX / Partner Center: blocked on Pier's account and certificate subject.
- T033-2 — automated winget update: needs a token (TBD, Pier's decision).
- T040 — `PED.run` winget package: only after T032-2 merges.

## Lessons
- 2026-10-16 — The PC's registered machine id can change after a reinstall; confirm with Pier before using a new id.
- 2026-10-11 — The GitHub integration cannot comment on microsoft/winget-pkgs (403); such comments are posted by Pier himself.
- 2026-09-27 — winget validation can fail if the publisher URL times out; first attempts under other package IDs were closed (URL and CLA issues).
