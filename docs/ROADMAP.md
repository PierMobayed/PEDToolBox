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

- PR to microsoft/winget-pkgs: https://github.com/microsoft/winget-pkgs/pull/442279 (`PED.Toolbox`; ped.run URLs removed after validator timeout)
- v1 stays on `ped.run` (`irm ped.run | iex`); v3 is winget + GitHub Release
- Partner Center MSIX signing (needs your publisher CN and account)
- Bulgarian UI strings
- Winget `--output json` parser
- Task Scheduler editor UI (backup scripts already exist)
- Optional portable third-party tools (not for Store)
- Switch GitHub default branch from `Tool` to `v3` when you are ready
