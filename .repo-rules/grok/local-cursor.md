# Local Cursor Agent (Pier's PC)

**Updated:** 2026-10-16  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

## Location

| Item | Value |
|------|-------|
| Machine | DESKTOP-2AMCEF1 (Pier's PC) |
| Bridge repo | PierMobayed/pm-bridge-system (`C:\Pier\pm-bridge-system`) |
| Inbound | Grok Coord → `grok-send-to-cursor.js` over CDP (port 9229) |
| Outbound | `bt-send-to-grok.js` → Grok Coord |

## Role

The PM Bridge and the Local Cursor Agent are **messaging only**. They do **not** handle releases for any project.

**Machine-Shell release projects:** **naChas**, **VesiTV**, and **Ped**. Those releases are done by **naChas Release**, **VesiTV Release**, and **Ped Release** via the machine Shell on Pier's PC (not Cursor, not PM Bridge).

Work that **must** stay on Pier's PC for this agent:

- Messaging between Grok Coord and the Local Cursor Agent via the bridge
- **Fallback** signed builds / publish only when the machine Shell is unavailable, **and only with Coord's go**
- Key backups in the private repo **PierMobayed/appkeys** — see [../common/signing-keys.md](../common/signing-keys.md)

**Not in scope:** product code — that belongs to `<project> Code` via cloud agent → PR → Review. Default signed builds and GitHub Releases are the machine-Shell Release bots, not this agent.

**Task sources:** Grok Coord (via the bridge) or Pier directly. No self-initiated work.

A **local worker** (`worker=laptop`, started by [../scripts/start-workers.ps1](../scripts/start-workers.ps1)) for Code cloud agents is allowed separately — see [../common/models-and-usage.md](../common/models-and-usage.md). That worker is not this messaging agent. Appkeys and passwords stay outside the agent workspace.

## Rules

| # | Rule |
|---|------|
| 1 | Stay inside the project folder named in the task. |
| 2 | Never delete files unrelated to that project. |
| 3 | Never print or log passwords or `local.properties` values (key **names** only). |
| 4 | Never commit/push from the PC except to **PierMobayed/appkeys**. |
| 5 | Keystores never leave the PC except as encrypted archives in appkeys; passphrase is typed by Pier himself. |
| 6 | APKs leave the PC only as a GitHub release asset. |
| 7 | No version bumps. |
| 8 | Release only from the **merge SHA** on the product branch (Ped = `v3`) with a **matching signing cert**. |
| 9 | Keep a local APK copy in `C:\Users\PierM\.<project>\`. |
| 10 | Report every step via `node C:\Pier\pm-bridge-system\scripts\bt-send-to-grok.js --subject ... --body ...`. |
| 11 | Talk to Pier in Bulgarian. |

See [../common/models-and-usage.md](../common/models-and-usage.md) rule 7: use Composer 2.5 or Grok 4.7 (low), not Auto; Coord bridge prompts start with the model line.

## Publishing approval (2026-10-08)

Pier approved on 2026-10-08: **Grok Coord may give the publish go** for releases run by the machine-Shell Release bots (**naChas Release**, **VesiTV Release**, **Ped Release**) after verifying:

1. Build is from the **merge SHA** on the product branch (Ped = `v3`)
2. Signing cert matches
3. No real AdMob IDs in the build

**naChas, VesiTV, and Ped:** once those checks pass, build and publish run **unattended**. Pier is contacted only if an approval card appears. Product may give the Release go if Coord is unavailable.

**Ped:** opening a **winget-pkgs** PR always needs Pier's explicit OK.

The Local Cursor Agent / PM Bridge is not the release path. Fallback publish via this agent is allowed **only when the machine Shell is unavailable, and only with Coord's go** after the same checks.

Coord does not need to wait for Pier for these machine-Shell releases. This is an exception to the general "Product + Pier OK" rule for live actions documented in [wake-rules.md](./wake-rules.md) and [FLEET.md](./FLEET.md).

## Per-repo rule files

Each product repo may carry a small Cursor rule file pointing back to this doc.

**This document is the source of truth** for the Local Cursor Agent's role and rules.
