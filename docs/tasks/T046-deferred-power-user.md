# T046 — do not rush Store-hostile / high-trust features

**Status as of 2026-10-12**


**Status:** deferred  
**Policy:** умишлено не бързаме.

## Goal

Keep heavy, Store-hostile, or high-trust features **out of the main v3 / Store / `PED.Toolbox` package** until a deliberate power-user channel exists (see T044).

| Feature | Where it can live instead |
|---|---|
| BleachBit / Revo (and similar) inside the app bundle | v1 bat, or T044 power-user download channel |
| Driver packs | v1, or a future optional download — never in Store SKU |
| Wi-Fi password dump | v1 only, or a clearly labeled power-user tool — not default UI |
| WinRE / account password reset | v1 only (WinRE scenario) |

Power-user channel (if we ever build it): separate entry (optional zip, `PED.Something`, or a hidden page), hash-checked downloads to `%LocalAppData%`. **Not** the Store SKU (`STORE_SKU`). See T044. Until then: leave these on **v1** (`Tool` / `ped.run`).

## Done

none yet (policy only)

## Still waiting

Pier / Product decision on if/when to build a power-user channel.

## Do not

- Do not add driver packs, Wi-Fi password dump, WinRE reset, or bundled cleaners to default v3 UI or Store SKU without Pier + Product.
- No winget-pkgs changes without Pier OK.
- No merge without Review + Product go.
