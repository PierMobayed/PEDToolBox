# repo-rules

Private org docs for Pier's Grok Bot fleet and Cursor roles.

Canonical repo: [https://github.com/PierMobayed/repo-rules](https://github.com/PierMobayed/repo-rules) (GitHub redirects from the previous name).

Projects **commit** a snapshot of this repo as `.repo-rules/` (plain files + `SYNCED_FROM`; not gitignored). Cloud agents need only the project repo. How: [cursor/SETUP.md](./cursor/SETUP.md).

**Layout (2026-10-16):**

- [common/](./common/) — shared: merge, signing keys/appkeys, models & usage (incl. Exceptions and rule 9), STATUS/NEXT/HISTORY (docs-rules)
- [grok/](./grok/) — Grok-bot-only: [FLEET.md](./grok/FLEET.md), wake, channels, [token economy](./grok/token-economy.md), release roles, local-cursor bridge, audit table
- [cursor/](./cursor/) — Cursor-only: [SETUP.md](./cursor/SETUP.md), [roles/](./cursor/roles/), subagent coordinator template
- [scripts/start-workers.ps1](./scripts/start-workers.ps1) — Pier's PC: one My Machines worker `laptop` with several `--worker-dir` ([`.ps1` ASCII-only](./common/ps1.md))
- [scripts/sync-rules.ps1](./scripts/sync-rules.ps1) — push `.repo-rules/` snapshot into fleet projects (use `-DryRun` first); [scripts/projects.ps1](./scripts/projects.ps1) shared project list

**Canonical Grok index:** [grok/FLEET.md](./grok/FLEET.md)

New bots: [Onboarding a new bot](./grok/FLEET.md#onboarding-a-new-bot)

Old root paths are **redirect stubs** (links keep working):

- [wake-rules.md](./wake-rules.md) → [grok/wake-rules.md](./grok/wake-rules.md) (merge: [common/merge-rule.md](./common/merge-rule.md))
- [models-and-usage.md](./models-and-usage.md) → [common/models-and-usage.md](./common/models-and-usage.md)
- [docs-rules.md](./docs-rules.md) → [common/docs-rules.md](./common/docs-rules.md)
- [release-roles.md](./release-roles.md) → [grok/release-roles.md](./grok/release-roles.md)
- [channels.md](./channels.md) → [grok/channels.md](./grok/channels.md)
- [fleet-audit-table.md](./fleet-audit-table.md) → [grok/fleet-audit-table.md](./grok/fleet-audit-table.md)
- [local-cursor.md](./local-cursor.md) → [grok/local-cursor.md](./grok/local-cursor.md)
- [FLEET.md](./FLEET.md) → [grok/FLEET.md](./grok/FLEET.md)

Maintained by **Org Desk**; inspected by **Grok Coord** (+ Pier).
