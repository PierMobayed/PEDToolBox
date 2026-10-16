# Local access: Remote Control, worker, visibility, builds

**Updated:** 2026-10-16 (Pier-approved)

How Pier runs agents on his PC vs in Cursor’s cloud. Worker setup is also in [SETUP.md](./SETUP.md) and [../common/models-and-usage.md](../common/models-and-usage.md). Messaging-only Local Cursor Agent: [../grok/local-cursor.md](../grok/local-cursor.md).

## Remote Control vs My Machines worker

| | **Remote Control (RC)** | **Worker `laptop`** |
|---|-------------------------|---------------------|
| What it is | Continues a **chat already open** in Cursor on the PC | Starts a **new** cloud agent run on Pier’s machine |
| Typical use | Steer the IDE session you already have | Product/Code brief: `worker=laptop` for builds/tests on the PC |

**RC requirements:** Cursor **≥ 3.9.8**, Settings → Agents → **Remote Control** on, PC stays awake, then use **/remote-control** (or the RC entry in the agent UI).

**Why RC can be missing:** old Cursor build, RC disabled in settings, PC asleep or offline, or the chat was never opened on that machine.

**Phone:** Android — install the [cursor.com/agents](https://cursor.com/agents) PWA; iPhone — Cursor app. RC controls an existing desktop chat; it does not replace `worker=laptop` for new agent runs.

## Worker `laptop`: install and troubleshoot

One worker named **`laptop`**, all project folders on it — not per-project workers, not a single `C:\Pier` root. Start with [../scripts/start-workers.ps1](../scripts/start-workers.ps1) (ASCII-only per [../common/ps1.md](../common/ps1.md)): seven `--worker-dir` entries (nachas, vesitv, liko, vaya, setupai, bridge, ped); missing dirs are skipped; PID under `%LOCALAPPDATA%\cursor-worker-laptop\`.

| Step | Action |
|------|--------|
| Install CLI | Bundled with Cursor, or install `cursor-agent` and run `agent --version` |
| Login | `agent login` — same Cursor account as the IDE and cloud agents |
| “No workers” in UI | Worker not running or PC asleep — run `start-workers.ps1`, keep PC awake |
| Debug | `agent worker debug` (paths, auth, registered dirs) |
| Match repo | Each `--worker-dir` folder must be a git clone with a **remote** Cursor can match to the agent’s repo |

API key: `~\.cursor\cursor-api-key.txt` via env only — never `--api-key` on the command line. If `laptop` is offline, launch on a Cursor VM instead ([models-and-usage](../common/models-and-usage.md)).

## Who sees what

| Actor | Sees |
|-------|------|
| **Local Cursor chat** (Pier in IDE) | Open files, local git, whatever is on disk in that folder |
| **Cloud agent** (Cursor VM) | Project repo in the VM + committed `.repo-rules/`; not Pier’s uncommitted PC edits |
| **Remote Control** | Same session as the open PC chat — not a separate memory |
| **Worker `laptop`** | New agent on PC: that clone’s files; still not other folders’ uncommitted work |
| **Grok bot** (Product, Code, …) | What Pier pastes, GitHub tools, and **repo files after push** |

Bots do **not** share chat memory with each other — only **git** (and docs in the repo). Cloud work that is **not pushed** is **not** on the PC until `git pull`.

## Where code lands and build cost

| Path | Landing |
|------|---------|
| **Cloud agent** | Edits on Cursor VM → commit → PR → merge; PC gets code via **pull** |
| **Worker / RC on PC** | Edits in the local clone; same PR workflow |

**Build cost:** Long **agent-run** builds (install, compile, huge logs) spend **Cursor** plan tokens. **Pier-run** builds on the PC (terminal, Gradle, etc. while he drives RC or locally) cost **no** agent tokens. Prefer PC-landing builds for heavy compile/test when `laptop` or RC is available.

## `/summarize` vs new agent (local vs cloud)

| Context | Guidance |
|---------|----------|
| **Local Cursor chat** | `/summarize` only compresses **that** chat; it does not replace fleet memory. Uncommitted wrap-up in chat is **lost** if not written to `docs/STATUS.md` / `docs/NEXT.md` ([docs-rules](../common/docs-rules.md) rule 13). |
| **New task** | New Cursor chat or new cloud agent — do not continue an old agent for a new PR/task ([models-and-usage](../common/models-and-usage.md) rules 4–5). |
| **Cloud agent wrap-up** | End of task: update `docs/STATUS.md` (and `docs/NEXT.md` if priorities changed); Product may add a matching `docs/HISTORY.md` row after analysis (see rule 13). |
