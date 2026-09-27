# T033-3 — in-app update check vs GitHub Release

**Status:** todo  
**Next together with:** T033-1 / T033-2

## Why

Winget upgrades appear only after Microsoft merges a PR. GitHub Release is immediate. The app should tell the user when a newer **Release** exists.

## Goal

- On Home or About, query `https://api.github.com/repos/PierMobayed/PEDToolBox/releases/latest` (or releases filtered to `v3*`).
- Compare to `FeatureCatalog.Version` / assembly version.
- If newer: show version + button to open the Release page (do **not** silently replace files).
- Optional later: download the zip with a progress bar and “open folder”.
- Respect rate limits; cache the result; work offline (fail quiet).
- No telemetry.

## Out of scope

Auto-install via winget inside the app until `PED.Toolbox` is actually in the community repo.
