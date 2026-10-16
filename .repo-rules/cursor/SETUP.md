# Cursor SETUP

**Updated:** 2026-10-16 (Pier-approved via Grok Coord)

Repo: [https://github.com/PierMobayed/repo-rules](https://github.com/PierMobayed/repo-rules) (GitHub redirects from the old name).

Each project **commits** a snapshot of this repo as **`.repo-rules/`** (plain files, no nested `.git`). Cloud agents then need **only the project repo**. Do not gitignore `.repo-rules/`. Do not attach this rules repo as a second cloud env repo. Do not `git pull` inside `.repo-rules/` (there is no git repo there after install).

The project also keeps a short `.cursor/rules/fleet.mdc` map (`alwaysApply: true`) pointing at `.repo-rules/` and `docs/STATUS.md`. Do not scatter-copy role files into other paths (`team/`, pasted `docs-rules.md`, etc.).

To install into an open project, **do not** send a bare `Ти си installbot` — the role file is not in the project yet. Always include the GitHub link. Copy this opener:

```text
Ти си installbot
https://github.com/PierMobayed/repo-rules/blob/main/cursor/roles/installbot.md
```

Read that URL first, then install. Role file: [roles/installbot.md](./roles/installbot.md).

## User Rule

Cursor → Settings → Rules → User Rules. Once. Applies to every local and cloud chat.

```text
If message starts with "Ти си <role>": read cursor/roles/<role>.md + common/, then project docs/STATUS.md
```

Those files are under **`.repo-rules/`** in the project (see fleet.mdc). `<role>` is `product`, `code`, `review`, `release`, `coord`, or `installbot` (lowercase file name). The line `Задача:` is the only task; do not expand it. First install uses the 2-line opener above (link required).

## Local workspace

Open the **project** folder. One My Machines worker named **`laptop`** serves every project folder (`--worker-dir` repeated). Several agents can run at once on that worker (no `--pool`). Product/Code launch with **`worker=laptop`**; if it is offline, fall back to a Cursor VM.

On Pier's PC, start it with [../scripts/start-workers.ps1](../scripts/start-workers.ps1) (must stay [ASCII-only](../common/ps1.md)) (editable dirs at the top, including ped `C:\Pier\PEDToolBox`; skips missing folders; PID `%LOCALAPPDATA%\cursor-worker-laptop\worker.pid`; no duplicate). API key from `~\.cursor\cursor-api-key.txt` via env, never `--api-key` on the command line. Cursor matches the agent’s repo to the right `--worker-dir` via git remotes. After install, rules are in committed `.repo-rules/`. Remote Control vs worker, troubleshooting, and who-sees-what: [local-access.md](./local-access.md).

Do **not** put `PierMobayed/appkeys` (or keystore/password folders) in the workspace. See [../common/signing-keys.md](../common/signing-keys.md). A local worker is allowed when the PC is online; see [../common/models-and-usage.md](../common/models-and-usage.md).

## Cloud environment

The cloud environment is **the project repo only**. Committed `.repo-rules/` is how the agent sees the rules. After a rules sync lands on the project's `main`, a **new** agent sees that snapshot. An already-open chat does not update.

## Sync (rule updates)

Rule updates **do not get a PR of their own**. They ride in the project's **next normal PR** as a **separate commit**:

`chore: sync repo-rules <sha>`

`<sha>` is the full commit SHA from `PierMobayed/repo-rules` recorded in `.repo-rules/SYNCED_FROM`.

**Exception:** an urgent rule change may be a small PR that contains **only** that sync commit.

Manual copy (installbot / one-off): clone or fetch `PierMobayed/repo-rules` to a temp dir, copy files into `.repo-rules/`, remove `.git`, write `SYNCED_FROM` with the SHA, **do not** add `.repo-rules/` to `.gitignore`.

## Sync rules into projects

On Pier's PC, after `repo-rules` changes land on `main`, push the same snapshot into every fleet project with [../scripts/sync-rules.ps1](../scripts/sync-rules.ps1) ([ASCII-only](../common/ps1.md)). Project paths and default branches live in [../scripts/projects.ps1](../scripts/projects.ps1) (shared with [start-workers.ps1](../scripts/start-workers.ps1)); the sync script skips the `repo-rules` folder itself.

1. Run **`-DryRun` first** — prints pull/sync/PR steps without changing git state in project repos (no `git fetch` for branch-exists checks).
2. Fix any **skip** reasons (missing folder, dirty tracked tree, active agent in that folder, branch `chore/sync-repo-rules-<shortsha>` already exists).
3. Run without `-DryRun` to create one PR per updated project. Optional **`-Only nachas,liko`** limits the set.

Behaviour matches installbot: replace `.repo-rules/` with a plain-file copy from canonical `C:\Pier\repo-rules` (no nested `.git`), exclude secret-like paths (see [roles/installbot.md](./roles/installbot.md)), set `.repo-rules/SYNCED_FROM` to the full 40-char SHA. Commit message: `chore: sync repo-rules (<shortsha>)`. Opens a PR via `gh` when available; otherwise prints the GitHub compare URL. Never merges.

Ties to the sync rule above: routine updates ride in the **next normal project PR** as that separate commit; **urgent** rule fixes may use a **sync-only** PR in each project (this script creates those). Review still checks only `SYNCED_FROM`, not rule prose.

## Review

Review **does not review** `.repo-rules/` content. It only checks that the folder matches the `PierMobayed/repo-rules` commit named in `.repo-rules/SYNCED_FROM`. See [roles/review.md](./roles/review.md).

## Per-project `.cursor/rules/fleet.mdc` (map only)

Short. `alwaysApply: true`. Does **not** paste the full documentation rules. Rules are the committed snapshot in `.repo-rules/`.

```markdown
---
description: Map to project docs and committed .repo-rules/ snapshot.
alwaysApply: true
---

# Fleet map

If the message starts with "Ти си <Роля>" (any case, including Product, Code, Review, Release, Coord, installbot), read `.repo-rules/cursor/roles/<role lowercase>.md`, then `.repo-rules/common/`, then `docs/STATUS.md`, before doing anything.

- `docs/STATUS.md` — current snapshot (read first; wrap up the task here)
- `docs/NEXT.md` — next Code task / priorities
- `docs/HISTORY.md` — done log; open a matching row only
- Rules live in committed `.repo-rules/` (plain files from https://github.com/PierMobayed/repo-rules). Read `.repo-rules/cursor/roles/<role>.md` + `.repo-rules/common/`
- Synced SHA: `.repo-rules/SYNCED_FROM`. Do not gitignore `.repo-rules/`. Do not git pull in `.repo-rules/`.
```

Canonical docs files and STATUS/NEXT/HISTORY: [../common/docs-rules.md](../common/docs-rules.md).

## Chat opener (3 lines)

```text
Ти си Product.
Задача: …
Работи по repo <project>.
```

Replace `Product` with `Code`, `Review`, `Release`, or `Coord` as needed. For **installbot**, use the 2-line opener with the GitHub link (above), not a bare `Ти си installbot`. New conversation per task. Wrap-up goes into `docs/STATUS.md`.
