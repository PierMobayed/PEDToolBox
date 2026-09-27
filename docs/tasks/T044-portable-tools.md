# T044 — optional portable third-party tools

**Status:** later (not Store)  
**Parent policy:** [T046](T046-deferred-power-user.md) — do not rush.

## Goal

Optional download of known portable utilities (e.g. BleachBit, Revo) into `%LocalAppData%` with hash check. Never ship inside the Store SKU or the default `PED.Toolbox` zip.

Until this exists, those tools remain **v1** (`irm ped.run | iex`).
