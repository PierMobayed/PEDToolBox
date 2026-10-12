# T049 — Fix hardcoded 3.1.0 in pack-release.ps1

**Status:** next  
**Owner:** Ped Code  
**Part of:** release tooling

## Problem

`pack-release.ps1` hardcodes version 3.1.0 in the zip file name. This is a known release blocker for future versions.

## Context

Decision: Pier, 2026-10-11 — Ped releases now run on Pier's PC through machine Shell, done by the Ped Release bot (same as naChas). The bridge and local Cursor are no longer used for releases. Known release blockers to plan later as code tasks: `pack-release.ps1` hardcodes 3.1.0 in the zip name; no signing cert (now resolved by the Store route — see [T048](T048-store-account.md)).

Today the version string also appears in `src/PedToolbox.App/PedToolbox.App.csproj`, `packaging/msix/Package.appxmanifest`, and the winget YAML templates under `packaging/winget/`. T049 should keep the zip name in sync with whichever source of truth the release script uses.

## Goal

Read the version from the project file or accept it as a parameter so the zip name matches the actual release version.

## Done

(none yet)

## Still waiting

(none)

## Do not

- Change Store signing, winget PR status, or MSIX submission (T032-2, T032-3, T048).
- Bump the shipped 3.1.0 release assets retroactively.
