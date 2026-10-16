# Launching a Cursor agent for a coding task

1. **One agent per task.** Launch exactly ONE Cursor agent. Never launch separate agents for Code or Review, and never a second agent for the same task.
2. **Check the worker.** Check whether the local worker `laptop` (Pier's PC) is online.
3. **Online:** launch the agent on `laptop` in the project's folder (e.g. `C:\Pier\bestSmartPrice`). Give it the FULL task text, not just a link.
4. **Offline:** start it with `repo-rules/scripts/start-workers.ps1`, then check again. If it still isn't up, use a cloud machine and tell Product why.
5. **Before work:** the agent runs `git fetch` + `git status` and pulls if behind. On a conflict it stops and asks Pier.
6. **Subagents.** Paste this line verbatim into the task text:
   "Работи по `.cursor/agents/` (или `.repo-rules/cursor/`): пусни Code и Review като субагенти, един по един, и отвори PR."
   The internal Review subagent is a cheap pre-PR check. The Grok Review bot still does the final PR review at the exact head SHA.
7. **Model:** composer-2.5 for small tasks, grok-4.7 for medium/long. Stronger models only with Pier's approval.
8. **Keys:** keys and passwords (appkeys) are never in project folders.
9. **Git:** always a PR, never direct to main. Report the PR number + head SHA. Do not merge.
10. **Concurrency:** several tasks may run on `laptop` at once, but at most ONE per project folder.
