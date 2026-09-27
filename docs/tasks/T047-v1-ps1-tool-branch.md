# T047 — v1 `PED.ps1` should pull the bat from branch `Tool`

**Status:** todo (v1 / `Tool` branch, not the WPF app)  
**Related:** T040, T045, `ped.run`

`PED.ps1` still downloads `PED-ToolBox.bat` from GitHub **`main`**. Default branch is **`Tool`**. If `ped.run` points at this script, it may not get the current v1.

Fix on branch `Tool` only (do not overwrite from `v3` except by an explicit commit there).
