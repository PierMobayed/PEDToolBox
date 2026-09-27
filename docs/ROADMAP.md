# Roadmap

## Done in 3.0.0 (this drop)

- v3 folder, solution, docs
- Dark Fluent WPF shell mapped to v1 steps
- Native restore, diagnostics, SFC/DISM launchers, privacy, winget, uninstall, startup, temp, recycle, service profiles, power/hibernate/indexing
- Activity log
- Winget YAML + MSIX manifest templates
- Publish script for a light EXE

## Next (3.1)

- Real app icon + Store assets
- Restore: registry / tasks / services export (v1 PED backup)
- Winget JSON output parser when the installed winget supports `--output json`
- Hide or disable `StoreSafe=false` pages with a compile flag `STORE_SKU`
- Bulgarian UI strings (resource `.resx`)

## Later

- Task Scheduler grid (from v1 Step 5)
- Optional download of well-known portable tools to `%LocalAppData%` with hash check (not for Store)
- CI on GitHub Actions: `dotnet build` + release zip
- Signed MSIX in Partner Center
