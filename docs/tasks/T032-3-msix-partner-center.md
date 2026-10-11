# T032-3 — signed MSIX → Partner Center

**Status:** waiting (on T048)  
**Part of:** 3.2 "да може да се инсталира"

## Goal

Sideload and/or Microsoft Store listing for PED Toolbox.

## Blocked on

**T048** — Create Microsoft Store (Partner Center) individual account and share publisher name. Owner: Pier.

## Signing approach

Decision: Pier, 2026-10-12 — signing goes through a free Microsoft Store individual developer account. Microsoft re-signs the MSIX after certification, so there is no SmartScreen warning. No paid code-signing certificate for now.

## Needs from Pier

- Partner Center account (T048)
- Store-assigned publisher CN
- Privacy policy URL
- Never commit `.pfx`

## In repo already

- `packaging/msix/Package.appxmanifest` (identity `PED.Toolbox`)
- Store-size logos under `packaging/msix/Assets`
- `STORE_SKU` so Services Apply is off for a Store build: `dotnet build -p:StoreSku=true`

## Steps when the account exists

1. Replace Publisher CN in the manifest with the Store value.
2. Pack with MakeAppx / Visual Studio packaging project.
3. Upload; Store signs the package.
4. Keep third-party portable cleaners out of this SKU.
