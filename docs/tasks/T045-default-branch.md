# T045 — v3 as the official GitHub product

**Status:** later  
**Do not do this until v3 is deliberately the public face of the repo.**

## Goal

When v3 is the official product:

1. GitHub → **Settings → Default branch → `v3`**.
2. The repo home page then shows v3 (README, clone default).
3. **v1 stays as branch `Tool`**. Say that clearly in the default README (v3): v1 lives on `Tool`; this tree is the WPF app.
4. **`ped.run` is a separate change.** If you only flip the default branch and forget DNS/`ped.run`, people still run `irm ped.run | iex` and get the **bat**. Point `ped.run` at v1 on purpose, or update it only when you want the one-liner to do something else.

## Do not

Point `ped.run` at `PEDToolbox.exe` by accident. Winget id stays `PED.Toolbox`; the domain is not the package id.
