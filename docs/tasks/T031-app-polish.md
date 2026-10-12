# T031 — 3.1 look and behave like an app

**Status as of 2026-10-12**


**Status:** shipped in 3.1.0  
See [HISTORY.md](../HISTORY.md).

## Goal

Ship 3.1 polish: icon and Store assets, Store-safe SKU flag, and PED-Recovery backup for registry / tasks / services.

## Done

| Item | Status |
|---|---|
| Icon + Store/MSIX assets | done |
| `STORE_SKU` hides/locks service Apply | done |
| PED-Recovery backup (registry / tasks / services) | done |

## Still waiting

Optional follow-ups live in other tasks: Bulgarian UI (**T041**), winget JSON parser (**T042**).

## Do not

- Do not reopen shipped 3.1.0 scope without Product go.
- No secrets or signing certs in the repo.
- No merge without Review + Product go.
