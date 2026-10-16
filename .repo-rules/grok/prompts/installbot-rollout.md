# Prompt: installbot rollout (Grok Product, Pier's PC)

**Updated:** 2026-10-16 (Pier-approved)

Ready text for a Grok **Product** bot to run installbot on the project folder on Pier's PC. One project at a time. `repo-rules` is **private**: the GitHub blob link works only with Pier's GitHub access (local git creds / Cursor GitHub app). If the Cursor agent cannot read the URL, clone with **local git** — never ask for a token.

Copy from **Do this** onward.

---

## Do this

You are Product. Run installbot on this project's folder on Pier's PC. Do not merge. Do not touch other repos.

1. In the **local project folder**: `git fetch` and `git status`. Compare HEAD with `origin` (the tracked branch).

2. Branching:
   - **Clean and up to date** with origin → continue.
   - **Behind** origin, working tree clean → `git pull`.
   - **Local changes or a conflict** → **STOP**. Ask Pier in this chat. Touch nothing.

3. Ensure worker **`laptop`** is running (all project `--worker-dir`s). If not, run [../../scripts/start-workers.ps1](../../scripts/start-workers.ps1). Launch the Cursor agent with **`worker=laptop`**. No cloud fallback.

4. Launch **one** Cursor agent on that worker only. Model: `composer-2.5`, effort low, fast off. **No cloud / Cursor VM fallback.** Prompt:

```text
Ти си installbot. Прочети и изпълни https://github.com/PierMobayed/repo-rules/blob/main/cursor/roles/installbot.md
```

If the agent cannot open that private URL, have it clone `PierMobayed/repo-rules` with local git (Pier's existing creds) and read `cursor/roles/installbot.md` from the clone. Never ask for a token.

5. When the agent opens a PR: report **PR link + full head SHA** to **Grok Coord**. Do not merge.

Role file (same as the URL): [../../cursor/roles/installbot.md](../../cursor/roles/installbot.md). SETUP: [../../cursor/SETUP.md](../../cursor/SETUP.md).
