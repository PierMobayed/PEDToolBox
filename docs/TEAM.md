# Team

**Status as of 2026-10-12**

People and bots that work on PED Toolbox (`v3`). **PR** means pull request; **SHA** is the git commit id.

## People

| Person | Role |
|---|---|
| **Pier** | Owner. Holds secrets, Partner Center / Microsoft Store account, final Store submission. Approves product direction when his decision is required. |

## Bots

| Bot | Role |
|---|---|
| **Ped Product** | Owns docs, phases, and priorities. Gives **go** on PRs (with PR # and head SHA). |
| **Ped Code** | Writes code via Cursor cloud agent PRs targeting `v3`. |
| **Ped Review** | Reviews open PRs: diff, `asInvoker` / elevation, Store/MSIX, winget manifests, secrets, accidental overwrites of `Tool` or v1. |
| **Ped Release** | Builds and publishes releases on Pier’s PC (machine Shell). Winget-pkgs PRs, MSIX / Partner Center prep. |
| **Grok Coord** | Fleet coordinator. Merges after Ped Review and Ped Product go. |

## Merge and release flow

```
PR opened → Ped Review → Ped Product go (PR # + head SHA) → Grok Coord merges → v3
```

For a **release**, after merge Grok Coord (or Product) wakes **Ped Release** with version, merge SHA, and approved head SHA. Details: [RELEASING.md](RELEASING.md).

**Rule:** nobody pushes to `v3` directly. Default git branch may still be `Tool` for v1; the WPF app product line is `v3` ([T045](tasks/T045-default-branch.md)).
