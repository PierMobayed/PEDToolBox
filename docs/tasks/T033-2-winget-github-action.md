# T033-2 — GitHub Action automatic winget-pkgs PR

**Status:** todo  
**Depends on:** T033-1 (small installer preferred), T032-2 **merged** so `PED.Toolbox` exists in the catalog

## Why

Today each version needs a manual `wingetcreate submit`. That is slow and easy to forget.

## Goal

On GitHub Release publish (branch `v3`):

1. Build the **winget** artifact (small zip from T033-1).
2. Compute SHA256.
3. Open/update a PR to `microsoft/winget-pkgs` for `PED.Toolbox` (komac, wingetcreate, or `vedantmgoyal2009/winget-releaser`).

## Notes

- Needs a PAT with access to the `winget-pkgs` fork (`PierMobayed/winget-pkgs`).
- First package (3.1.0) stays manual; this is for **3.1.1+**.
- Action must not upload `.pfx`.
