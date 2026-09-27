# T032-1 — zip → GitHub Release

**Status:** done (3.1.0)  
**Part of:** 3.2 “да може да се инсталира”

## Goal

Publish a downloadable build without requiring `dotnet` on the user’s PC.

## Done

- `packaging/publish-exe.ps1` and `packaging/pack-release.ps1`
- Release tag [v3.1.0](https://github.com/PierMobayed/PEDToolBox/releases/tag/v3.1.0)
- Asset: `PEDToolbox-3.1.0-win-x64.zip` (**self-contained**, packed with `-SelfContained`). GitHub lists the zip at **57.8 MB**. The unpacked folder is much larger (~140 MB). Users unzip and run `PEDToolbox.exe` with no .NET install.

## Note

The first public zip is self-contained on purpose. Lighter zips are **T033-1**.
