# T040 — v1 as winget package `PED.run`

**Status:** proposed  
**Blocked by:** T032-2 **merge** (pipeline is already green; do not submit a second package until `PED.Toolbox` is in the catalog or a moderator asks for a split)

## Goal

- GitHub Release zip of v1 (`PED-ToolBox.bat` + small `.cmd` launcher), not `irm ped.run | iex`
- Manifest id `PED.run`, display name like “PED Toolbox Classic”
- Domain `ped.run` can stay the one-liner; winget is a second channel

Two **different** products: v1 batch vs v3 WPF. That is allowed. Two ids for the **same** exe is not.

## Done

none yet

## Still waiting

- T032-2 merge (or moderator guidance) before opening `PED.run` in winget-pkgs.

## Do not

Point `PED.run` at `PEDToolbox.exe` (v3). No winget-pkgs PR for `PED.run` without Pier OK and without T032-2 resolved. No merge without Review + Product go.
