# T032-3 — signed MSIX → Partner Center

**Status as of 2026-10-12**


**Status:** waiting (external: Pier Store account T048)    
**Part of:** 3.2 "да може да се инсталира"

## Goal

Sideload and/or Microsoft Store listing for PED Toolbox.

## Done

- `packaging/msix/Package.appxmanifest` (identity `PED.Toolbox`)
- Store-size logos under `packaging/msix/Assets`
- `STORE_SKU` so Services Apply is off for a Store build: `dotnet build -p:StoreSku=true`
- Signing approach agreed: free Microsoft Store individual account; Microsoft re-signs MSIX after certification (Decision: Pier, 2026-10-12 — see [PACKAGING.md](../PACKAGING.md)).

## Still waiting

- **T048** — Pier creates Partner Center account and shares Store-assigned publisher CN.
- Privacy policy URL from Pier for Store listing.
- Steps when the account exists: replace Publisher CN in the manifest; pack with MakeAppx / VS packaging; upload for Store signing; keep third-party portable cleaners out of this SKU.

## Do not

- Never commit `.pfx` or other signing secrets.
- No Partner Center submit or Pier-only account steps without Pier.
- No bundling third-party portable cleaners in the Store SKU.
- No merge without Review + Product go.
