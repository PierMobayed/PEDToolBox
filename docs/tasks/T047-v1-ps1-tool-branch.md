# T047 — v1 `PED.ps1` should pull the bat from branch `Tool`

**Status as of 2026-10-12**


**Status:** proposed  
**Related:** T040, T045, `ped.run`

## Goal

`PED.ps1` still downloads `PED-ToolBox.bat` from GitHub **`main`**. Default branch is **`Tool`**. If `ped.run` points at this script, it may not get the current v1.

Fix on branch `Tool` only (do not overwrite from `v3` except by an explicit commit there).

## Done

none yet

## Still waiting

nothing

## Do not

- **No fixes on branch `v3`** for v1 `PED.ps1` / bat — work on **`Tool` only**.
- Do not point `ped.run` or winget `PED.run` at v3 `PEDToolbox.exe`.
- No merge without Review + Product go.
