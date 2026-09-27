# Packaging — winget and Microsoft Store

## Identifiers (fill real publisher when you have a cert)

| Field | Value used in templates |
|---|---|
| Package name | `ped.run` |
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

## 1. Light EXE / zip

```powershell
cd v3
.\packaging\pack-release.ps1
```

Output: `v3/artifacts/PEDToolbox-3.1.0-win-x64.zip` and `artifacts/SHA256.txt`.

Icons: `.\packaging\make-icons.ps1` (already run for 3.1.0).

Framework-dependent publish only:

The default script uses **framework-dependent** `win-x64` so the download stays small. Users install [.NET 8 Desktop Runtime](https://dotnet.microsoft.com/download/dotnet/8.0).

For a fatter “just run it” zip, pass `-SelfContained`.

## 2. Winget

Templates: `packaging/winget/`

1. Publish and sign the installer (MSIX preferred, EXE zip also works).
2. Host it on GitHub Releases and compute SHA256.
3. Put the URL and hash into `ped.run.installer.yaml`.
4. Open a PR to [microsoft/winget-pkgs](https://github.com/microsoft/winget-pkgs) under `manifests/p/ped/run/3.1.0/`.

Users then run:

```text
winget install ped.run
```

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
