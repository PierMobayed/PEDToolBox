# T033-2 — GitHub Action automatic winget-pkgs PR

**Status as of 2026-10-12**


**Status:** proposed  
**Depends on:** T033-1 (small installer preferred), T032-2 **merged** so `PED.Toolbox` exists in the catalog

## Goal

On GitHub Release publish (branch `v3`):

1. Build the **winget** artifact (small zip from T033-1).
2. Compute SHA256.
3. Open/update a PR to `microsoft/winget-pkgs` for `PED.Toolbox` (komac, wingetcreate, or `vedantmgoyal2009/winget-releaser`).

Today each version needs a manual `wingetcreate submit`. That is slow and easy to forget. First package (3.1.0) stays manual; this is for **3.1.1+**. Needs a PAT with access to the `winget-pkgs` fork (`PierMobayed/winget-pkgs`).

## Done

none yet

## Still waiting

- T032-2 merge so the catalog entry exists.
- T033-1 small artifact (preferred).

## Do not

- Do not store PATs or other secrets in the repo or workflow logs.
- Action must not upload `.pfx`.
- Do not open any winget-pkgs PR without Pier's explicit OK.
- No merge without Review + Product go.
