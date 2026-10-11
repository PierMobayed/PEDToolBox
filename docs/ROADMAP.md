# Roadmap

## Done in 3.1.0

- Icon + Store/MSIX image assets
- `STORE_SKU` compile flag
- PED-Recovery backup (registry / tasks / services, optional drivers)
- Release zip script + CI build on `v3`

## Done in 3.0.0

- v3 folder, solution, docs, starter bat
- Dark Fluent WPF shell mapped to v1 steps
- Native restore, diagnostics, SFC/DISM launchers, privacy, winget, uninstall, startup, temp, recycle, service profiles, power/hibernate/indexing
- Activity log
- Winget YAML + MSIX manifest templates

## After this plan (upgrade later)

Tracked in [TASKS.md](TASKS.md). **Next:** T048 (Pier creates Microsoft Store account, unblocks T032-3 and winget via msstore). After T032-2 merge, or in parallel: T033-1 light installer, T033-2 winget GitHub Action, T033-3 in-app GitHub Release update check. T030 (formal UI review) can run anytime. 3.2 leftover: T032-2 **moderator merge**, T032-3 Partner Center (waiting on T048). T047 is a v1/`Tool` fix, not this tree. T049 fixes the hardcoded 3.1.0 in `pack-release.ps1` (release blocker).

Later (do not rush): T045 official default branch + `ped.run` kept separate; T046 power-user / Store-hostile features stay on v1.

Finished work by version: [HISTORY.md](HISTORY.md).
