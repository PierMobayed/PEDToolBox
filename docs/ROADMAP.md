# Roadmap

**Status as of 2026-10-30**

**Now:** T048 by Pier (Store account + listing docs); waiting on winget moderator (T032-2); **T049** (pack-release version) before the next release.

Task index: [TASKS.md](TASKS.md).

## Done in 3.1.0

- Icon + Store/MSIX image assets
- `STORE_SKU` compile flag
- PED-Recovery backup (registry / tasks / services, optional drivers)
- Release zip script + CI build on `v3`
- GitHub Release zip (T032-1)

## Done in 3.0.0

- v3 folder, solution, docs, starter bat
- Dark Fluent WPF shell mapped to v1 steps
- Native restore, diagnostics, SFC/DISM launchers, privacy, winget, uninstall, startup, temp, recycle, service profiles, power/hibernate/indexing
- Activity log
- Winget YAML + MSIX manifest templates

## 3.2 — installable (GitHub zip, winget, Store)

**Success criteria**

- Winget PR `PED.Toolbox` merged; `winget install PED.Toolbox` works from the community repo.
- Store listing submitted with Store-signed MSIX (Services Apply stays out of Store SKU).
- Release zip and winget manifests stay version-aligned (T049 fixed before next ship).

**Owner gate:** Phase 3.3 starts only after **Ped Product** reviews outcomes, and **Pier** where his decision or Store account is required (T048, listing secrets).

Open items: T048 (Pier), T049 (release blocker), T032-2, T032-3, T040 (after winget merge), plus T033-1/T033-2 in parallel when green.

## 3.3 — lighter installer + update check

**Success criteria**

- Default winget/GitHub artifact is framework-dependent or MSIX so Installation Validation downloads stay small (T033-1).
- Publishing a GitHub Release opens or updates the winget-pkgs PR automatically (T033-2).
- App can tell the user when a newer GitHub Release exists (T033-3).

**Owner gate:** Same as 3.2 — **Ped Product** sign-off; **Pier** for any product calls that affect Store or distribution.

## Later (do not rush)

Deferred in backlog: T045 (default branch / `ped.run`), T046 (power-user / Store-hostile features on v1). Pier decides timing.

Finished work by version: [HISTORY.md](HISTORY.md).
