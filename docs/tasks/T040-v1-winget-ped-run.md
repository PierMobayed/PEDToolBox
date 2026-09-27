# T040 — v1 as winget package `PED.run`

**Status:** todo  
**Blocked by:** T032-2 **merge** (pipeline is already green; do not submit a second package until `PED.Toolbox` is in the catalog or a moderator asks for a split)

## Why

Two **different** products: v1 batch vs v3 WPF. That is allowed. Two ids for the **same** exe is not.

## Goal

- GitHub Release zip of v1 (`PED-ToolBox.bat` + small `.cmd` launcher), not `irm ped.run | iex`
- Manifest id `PED.run`, display name like “PED Toolbox Classic”
- Domain `ped.run` can stay the one-liner; winget is a second channel

## Do not

Point `PED.run` at `PEDToolbox.exe` (v3).
