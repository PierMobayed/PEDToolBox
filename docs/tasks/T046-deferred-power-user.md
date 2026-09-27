# T046 — do not rush Store-hostile / high-trust features

**Status:** later  
**Policy:** умишлено не бързаме.

These stay **out of the main v3 / Store / `PED.Toolbox` package**. They are heavy for Microsoft Store review and for user trust.

| Feature | Where it can live instead |
|---|---|
| BleachBit / Revo (and similar) inside the app bundle | v1 bat, or T044 power-user download channel |
| Driver packs | v1, or a future optional download — never in Store SKU |
| Wi-Fi password dump | v1 only, or a clearly labeled power-user tool — not default UI |
| WinRE / account password reset | v1 only (WinRE scenario) |

## Power-user channel (if we ever build it)

Separate entry (optional zip, `PED.Something`, or a hidden page), hash-checked downloads to `%LocalAppData%`. **Not** the Store SKU (`STORE_SKU`). See T044.

Until then: leave these on **v1** (`Tool` / `ped.run`).
