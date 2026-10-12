# T044 — optional portable third-party tools

**Status as of 2026-10-12**


**Status:** deferred  
**Parent policy:** [T046](T046-deferred-power-user.md) — do not rush.

## Goal

Optional download of known portable utilities (e.g. BleachBit, Revo) into `%LocalAppData%` with hash check. Never ship inside the Store SKU or the default `PED.Toolbox` zip.

Until this exists, those tools remain **v1** (`irm ped.run | iex`).

## Done

none yet

## Still waiting

Product decision to prioritize (deferred with T046).

## Do not

- No bundling BleachBit/Revo or similar inside Store SKU or default `PED.Toolbox` zip.
- No winget-pkgs PR without Pier OK.
- No merge without Review + Product go.
