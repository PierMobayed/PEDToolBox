# Model & usage rule (Cursor Pro+ quota)

**Updated:** 2026-10-16 (Pier-approved via Grok Coord)  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

**Reason:** on 2026-10-11, one day into Pro+, "Other Models" usage was at 74% while Cursor Models were at 5%. Pier asked for this rule. Defaults below are Pier's 2026-10-16 cut.

Applies to every bot that launches or resumes a Cursor cloud agent, to the Local Cursor Agent, and to Cursor Product/Coord launching Code or Review as subagents.

Grok Bot has no model picker for its own chat. These lines apply to the cloud agents the bots launch, and to the Local Cursor Agent.

**Separate bills (Pier, 2026-10-16):** Grok’s weekly package and Pier’s **Cursor** plan are different products — stopping or saving on one does **not** refill the other.

1. **Default model:** a Cursor Models pool model only (Grok 4.7 `grok-4.7` or Composer 2.5 `composer-2.5`). Every brief states the model and effort on one line. The same model named in the brief text is the model passed at launch. `fast off` is a **launch parameter**, not a sentence in the prompt text. On Pro+, Fast is the product default; launching `composer-2.5-fast` or `grok-4.7-high-fast` costs about two to six times more. Never use high or max effort, Fast mode, or Max Mode.

   Size → model (Pier, 2026-10-16):
   - **Small tasks:** `composer-2.5`, effort low, fast off.
   - **Medium / long:** `grok-4.7` (effort low by default; medium only for non-trivial logic or layout, and the brief says why), fast off.
   - **Complex:** stronger **Other Models** only after Product justification **and** Pier DM OK (rule 2). Do not treat Fable, Fast, high, Gemini Flash, or Muse as habit.

   Cursor IDE default model is also Composer 2.5 without Fast.

2. **Other Models** (Claude, GPT, Gemini or any other third-party model, including as a subagent) only when the project's Product writes a justification in the brief (`Other model: <id>, because <reason>`) AND Pier OKs it in DM.

   If Pier OKs, pick from:
   - normal code: Claude Sonnet 5.5, medium, no fast (not “Claude Sonnet 5”)
   - very short task: GPT-5.6 Luna, no fast
   - Sonnet or Grok 4.7 not enough: Claude Opus 5.5, medium, no fast

3. **No third-party subagents.** Don't ask cloud agents for computerUse/browser screenshot checks or media review, because these run on claude-4.5-sonnet / gemini-3.1-pro and bill Other Models. Check previews with Vercel/CI status or ask Pier. Browser/visual checks follow rule 9 (Pier's explicit yes after a plain cost warning).

4. **One cloud agent per PR.** Follow-ups for that PR reuse that agent. A new PR or task id starts a fresh agent. Never feed a new task into an old agent.

5. **No idle or long-running agents.** Batch review fixes into one follow-up. Don't resume an agent just to report CI status. Once its PR is merged or closed, the agent gets no more messages. An agent with no progress for 60 min is stopped by its Code bot or reported to Coord.

6. **Review and Product bots** do not launch cloud agents to read code. They use the GitHub tools (diff, files, checks). Cursor Review as a subagent still reviews the open PR; it does not become the Code worker.

7. **The Local Cursor Agent** (bridge, Pier's PC) uses a Cursor Models model explicitly (Composer 2.5 or Grok 4.7, low), not Auto. Every bridge prompt from Coord starts with the model line.

8. **Budget watch:** if Other Models goes past 80%, all bots are Cursor-Models-only until reset, with no exceptions except Pier's direct OK.

9. **Expensive actions need Pier's explicit yes.** Before any expensive action (browser tests, screenshots, computerUse, or other browser/visual/media subagents), the bot must first tell Pier plainly that it will be expensive and ask "Сигурен ли си, че искаш да го направя?" It acts only after Pier explicitly confirms. Product's justification alone is not enough. Applies to all bots and cloud agents. (Pier, 2026-10-11.) This rule excludes the product's own Playwright tests, which run only in CI.

**Local worker (Pier, 2026-10-16):** one My Machines worker named **`laptop`** with several `--worker-dir` (nachas, vesitv, liko, vaya, setupai, bridge, ped=`C:\Pier\PEDToolBox` on `v3`). Start it with [../scripts/start-workers.ps1](../scripts/start-workers.ps1). Product/Code launch with **`worker=laptop`**; if it is offline, use a Cursor VM. Several tasks may run at once on that worker (My Machines, not `--pool`). Cloud and local agents use the **committed** `.repo-rules/` snapshot in the project (see [../cursor/SETUP.md](../cursor/SETUP.md)); they do not attach a second rules repo. If the PC is asleep, the agent runs on a Cursor VM. In both cases the agent is **new for the new task**. Remote Control is not this switch (it is a chat already open in Cursor on the PC). Machine Shell for naChas Release, VesiTV Release, and Ped Release is unchanged. Appkeys and passwords stay **outside** the agent workspace — see [signing-keys.md](./signing-keys.md).

**New conversation per task (Pier, 2026-10-16):** Grok bots start a new conversation with the same bot (do not delete or duplicate the bot). Cursor: a new chat per task. Task wrap-up is written into the project's `docs/STATUS.md` (see [docs-rules.md](./docs-rules.md)). Compressing context in the same chat does not lower the bill.

**Exceptions:** Agents listed here are allowed under rule 4 by the daily usage audit; new exceptions are added only after Pier approves them (reported via the project's Product or Grok Coord).

- Vessy PM bot cloud agent `bc-af7a996c` — long-lived by design; post-merge summaries for Vaya continue to go here (Pier-approved exception to rules 4 and 5, and to the related "new head SHA or HIGH+ finding voids the go" merge rule in [merge-rule.md](./merge-rule.md)). For reference: Vaya Code moved the PR #20 fixes to a new agent, `bc-b375a623`, on `grok-4.7` low, in line with rule 4. Wake rarely; not a daily long chat.
- naChas main architect cloud agent `bc-4e8c178b-4920-4f0e-8444-05ea7351ff77` — long-lived by design (advisory only: guards the formula, tabs and overlay; never pushes to main). Pier approved 2026-10-11. Rules 1, 2 and 9 still apply to it (Cursor Models model, effort low, no expensive actions without Pier's explicit yes). Wake rarely; not a daily long chat.
- rule 9 one-time onboarding avatar exception (see [../grok/FLEET.md#onboarding-a-new-bot](../grok/FLEET.md#onboarding-a-new-bot)).
