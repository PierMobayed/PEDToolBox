# Packaging — winget and Microsoft Store

## Identifiers (fill real publisher when you have a cert)

| Field | Value used in templates |
|---|---|
| Package name | `PED.Toolbox` |
| Display name | PED Toolbox |
| Version | 3.1.0 |
| Publisher display | PED Toolbox |
| Publisher CN | `CN=PED Toolbox` (replace with your Authenticode / Store CN) |

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

Output: `artifacts\PEDToolbox-3.1.0-win-x64.zip` and `artifacts\SHA256.txt`.

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
- a **GitHub Action** that opens the `winget-pkgs` PR when you publish a Release (see tasks T033-1 and T033-2)

Keep a self-contained zip on GitHub as an optional extra if you still want a zero-runtime download. In-app “is there a newer GitHub Release?” is T033-3 — that path does not wait for winget merge.

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

Never commit `.pfx` files. Use a purchased Authenticode cert or Store signing after upload.
