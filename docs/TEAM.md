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
| **Grok Coord** | Fleet coordinator. **Merges** PRs after the merge gate below. Ped Product merges only if Coord is unavailable. |

## Merge gate (every PR to `v3`)

Before merge:

1. **Ped Review** approves the **latest** PR **head SHA** (the commit at the tip of the branch).
2. **CI** is green on that SHA.
3. **Ped Product** gives a **go** that names the PR **#** and that same **head SHA**.

Any **new push** after the go voids the old approve/go — Ped Review must re-approve and Ped Product must give a new go on the new head SHA.

Changes that touch **secrets, keys, signing, payments, or DB deletes** (including **MSIX / Microsoft Store signing**) also need **Pier’s explicit OK in DM** before merge.

**Grok Coord** merges. **Ped Product** is the fallback merger only if Coord is unavailable.

Opening a PR to **microsoft/winget-pkgs** always needs **Pier’s explicit OK** (DM or equivalent), even when manifests were prepared in this repo.

## Release handoff

```
PR opened → merge gate → Grok Coord merges → v3 → wake Ped Release (version + merge SHA + approved head SHA)
```

Details: [RELEASING.md](RELEASING.md).

**Rule:** nobody pushes to `v3` directly. Default git branch may still be `Tool` for v1; the WPF app product line is `v3` ([T045](tasks/T045-default-branch.md)).
