# Packaging — winget and Microsoft Store

**Status as of 2026-10-30**

## Identifiers (fill real publisher when you have a cert)

| Field | Intended value |
|---|---|
| Package name | `PED.Toolbox` |
| Display name | PED Toolbox |
| Version | 3.1.0 |
| Publisher display | PED Toolbox (the appxmanifest template currently has `PublisherDisplayName=PierMobayed`; final value via T048) |
| Publisher CN | This table shows the intended values; the appxmanifest template (`packaging/msix/Package.appxmanifest`) currently uses `CN=PierMobayed`; the final CN comes from T048 (Pier's Store account) |

## Store SKU vs full

Default builds are the **full** desktop SKU (service profile Apply is available).

```powershell
dotnet build PedToolbox.sln -c Release -p:StoreSku=true
```

That defines `STORE_SKU`, hides the Services page, and no-ops Apply.

## Program vs source on GitHub

Release **assets** are only the built zip. Do not upload the repo. Users should get:

`https://github.com/PierMobayed/PEDToolBox/releases/download/v3.1.0/PEDToolbox-3.1.0-win-x64.zip`

GitHub still auto-adds “Source code (zip)” on the tag page; that cannot be disabled. Tell people to ignore it. Full rule: [DOWNLOAD.md](DOWNLOAD.md).

## 1. Zip for GitHub (what 3.1.0 actually shipped)

```powershell
cd v3
.\packaging\pack-release.ps1 -SelfContained
```

Output: `artifacts\PEDToolbox-3.1.0-win-x64.zip` and `artifacts\SHA256.txt`. Both `artifacts/` and `/release/` stay in `.gitignore`.

After build, Ped Release copies the zip to **`C:\Pier\releases\ped\<version>\`** on Pier’s PC (fleet release rule). That path is **not** in git. Publish zips **only** as GitHub Release assets; never commit them to `v3`.

The **3.1.0 Release** used `-SelfContained`. GitHub shows the zip as **57.8 MB**. Unpacked it is a full .NET bundle (~140 MB class). No runtime install for the user.

Without `-SelfContained` the script is **framework-dependent** (smaller; needs [.NET 8 Desktop Runtime](https://dotnet.microsoft.com/download/dotnet/8.0)). That is the intended default for later winget updates (T033-1).

Icons: `.\packaging\make-icons.ps1` (already run for 3.1.0).

## 2. Winget

Templates: `packaging/winget/`

1. Publish and sign the installer (MSIX preferred, EXE zip also works).
2. Host it on GitHub Releases and compute SHA256.
3. Put the URL and hash into `PED.Toolbox.installer.yaml`.
4. Open a PR to [microsoft/winget-pkgs](https://github.com/microsoft/winget-pkgs) under `manifests/p/PED/Toolbox/3.1.0/`.

Current PR (open, validated, awaiting moderator): [winget-pkgs#442279](https://github.com/microsoft/winget-pkgs/pull/442279). `winget install PED.Toolbox` works **after merge**, not while the PR is only open.

Later packages can share the same publisher prefix, for example `PED.Example`.

## Winget updates should stay small

The 3.1.0 Release zip is **self-contained** (57.8 MB on GitHub; unpacked much larger). Microsoft’s winget **Installation Validation re-downloads that file on every new version**. 3.1.0 already passed that check; later versions should still prefer a smaller artifact.

For later updates, prefer:

- a **framework-dependent** zip plus [.NET 8 Desktop Runtime](https://dotnet.microsoft.com/download/dotnet/8.0), or **MSIX**
- a **GitHub Action** that opens the `winget-pkgs` PR when you publish a Release (see [TASKS.md](../TASKS.md) T033-1 and T033-2)

Keep a self-contained zip on GitHub as an optional extra if you still want a zero-runtime download. In-app “is there a newer GitHub Release?” is [T033-3](tasks/T033-3-app-update-check.md) — that path does not wait for winget merge.

## 3. Microsoft Store / sideload MSIX

File: `packaging/msix/Package.appxmanifest`

Store checklist:

- Partner Center account, reserved name **PED Toolbox**
- Replace `Publisher` with the Store-assigned CN
- Generate Store logos (44, 150, 310) — placeholder names are in the manifest
- Build MSIX with the Windows SDK `MakeAppx` / Visual Studio packaging project, then submit
- Keep **Services → Apply** out of the Store SKU or behind a hidden flag (`FeatureItem.StoreSafe`)
- Do not bundle third-party portable cleaners
- Privacy policy URL (needed for Store listing)
- Capabilities: currently none beyond `runFullTrust` (classic Win32 packaged as desktop bridge)

`runFullTrust` is expected for this class of toolbox. Partner Center will review it.

## Signing

Never commit `.pfx` files. **Store MSIX:** submit through Partner Center; Microsoft re-signs after certification (no SmartScreen on the Store package). **GitHub zip and winget** stay unsigned for now — Windows SmartScreen may warn on those downloads; the no-SmartScreen note applies only to the Store MSIX, not the zip.

### Decisions

**Decision: Pier, 2026-10-12** — Ped will be signed through a free Microsoft Store individual developer account using MSIX. Microsoft re-signs the package after certification, so there is no SmartScreen warning. No paid code-signing certificate for now. Next step: Pier creates the Partner Center account at [storedeveloper.microsoft.com](https://storedeveloper.microsoft.com) (free for individuals, needs ID + selfie) and shares the publisher name for the MSIX manifest (T048). That unblocks T032-3 (signed MSIX to Partner Center). After the app is in the Store, winget can also point at the `msstore` source.

**Decision: Pier, 2026-10-11** — Ped releases now run on Pier's PC through machine Shell, done by the Ped Release bot (same as naChas). The bridge and local Cursor are no longer used for releases. Known release blockers to plan later as code tasks: `pack-release.ps1` hardcodes 3.1.0 in the zip name (T049); no signing cert (now resolved by the Store route above).

### winget-pkgs status

PR [#442279](https://github.com/microsoft/winget-pkgs/pull/442279) (`PED.Toolbox`) is still waiting on a Microsoft moderator.
