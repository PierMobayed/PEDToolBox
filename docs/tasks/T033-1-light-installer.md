# T033-1 — smaller installer for faster winget updates

**Status:** todo  
**Next after:** T032-2 is healthy (or in parallel if we only change *future* artifacts)

## Why

The 3.1.0 GitHub zip is self-contained (**57.8 MB** compressed; unpacked ~140 MB). Every winget update re-downloads and scans that installer. A large all-in-one binary still costs scan time even though 3.1.0 already passed Installation Validation.

## Goal

Ship a **small** default artifact for winget:

- **Framework-dependent** `win-x64` zip (user needs [.NET 8 Desktop Runtime](https://dotnet.microsoft.com/download/dotnet/8.0)), **or**
- **MSIX** (T032-3) which can use framework packages

Keep a self-contained zip on GitHub Release as an optional “just run it” asset if we still want zero-runtime users.

## Implementation sketch

1. `pack-release.ps1` without `-SelfContained` as the winget asset (already the script default).
2. Declare `PackageDependencies` on .NET Desktop Runtime in the winget installer YAML if required.
3. Point `PED.Toolbox.installer.yaml` at the small zip; new SHA256.
4. Document both assets on the Release notes.

Detail also in [PACKAGING.md](../PACKAGING.md) § Winget updates should stay small.
