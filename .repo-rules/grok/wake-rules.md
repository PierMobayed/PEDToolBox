# Wake rules (fleet protocol)

**Updated:** 2026-10-16  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

## Chain (no mutual fan-out)

```
Pier or Grok Coord
        ↓
     Product
        ↓
      Code
```

**Review** wakes only on:
- an **open PR**, or
- a concrete **preview URL** / review ask from Pier, Coord, HR Desk, or Product

**SetupAI Jobs / Leads** report to **SetupAI Product** (go/no-go). Live apply / binding outreach only after Product and/or Pier OK.

**naChas:** live actions (publishing APK, Play billing, anything driver-facing — meaning user-visible app changes for the driver) require Product + Pier OK. **Exception (2026-10-08):** releases run by the machine-Shell Release bots (**naChas Release**, **VesiTV Release**, **Ped Release**) — Grok Coord may give the publish go after verifying the merge SHA on the product branch, cert match, and no real AdMob IDs. Product may give the Release go if Coord is unavailable. The Local Cursor Agent does not run naChas (or any) releases.

**Ped publishing (2026-10-11):** pre-authorized the same way as naChas. Build and publish run unattended once all checks pass; Pier is contacted only if an approval card appears. Opening a **winget-pkgs** PR always needs Pier's explicit OK.

## Hard rules

1. **Pier / Grok Coord → Product** for scope, phases, docs, priority.
2. **Product → Code** only with a concrete coding brief (task id, acceptance, files/area).
3. **Review** does **not** wake Product or Code by default. No "all bots, please look" fan-out.
4. **HR Desk** (shared) designs and maintains bots for every project; it does not wake other projects' fleets. It also scores SetupAI achievements when asked. Per-project HR bots retired 2026-10-11.
5. **Code / Review / Release / Jobs / Leads** stay quiet until a real assigned task or open PR. No standing "any news?" polls.
6. Cross-project asks go through **Grok Coord**, not sideways pings between Liko ↔ Ped ↔ Vaya ↔ SetupAI ↔ naChas ↔ VesiTV.
7. **main is unprotected (R-3).** Review bots flag commits that landed on `main` without a PR.

New bots: first message is the onboarding avatar prompt — see [FLEET.md § Onboarding a new bot](./FLEET.md#onboarding-a-new-bot).

**Grok chats (Pier, 2026-10-16):** new task = new conversation with the same bot. Do not delete or duplicate the bot (a duplicate loses memory). Standing rules live in the bot description, not a long chat. End of task: wrap-up in `docs/STATUS.md`. Compressing context in the same chat does not lower the bill. Do not wake for routine with no new work. **Token economy:** tasks by 1:1 DM to the one bot that acts; groups only for fleet-wide news/rule changes; no 2-bot groups. See [token-economy.md](./token-economy.md).

## Merge rule

Canonical text: [../common/merge-rule.md](../common/merge-rule.md).

**Who merges:** Grok Coord is the **first choice** for merging PRs on all Pier's projects (naChas/beatSmartPrice, Vaya, Liko TV, PED Toolbox, SetupAI, VesiTV/tv1, **pm-bridge-system**). The project's **Product bot** is the **second choice**, used only if Coord is unavailable. Code and Review bots never merge.

**Preconditions:**
1. Review approves the latest head SHA
2. CI is green on that head
3. Product gives the go naming the PR number and head SHA

The PR must not be a draft — no draft PRs get merged.

A COMMENT review or a channel OK counts as approval only if it names the **full** head SHA (40 characters).

**CI green** means every check run passed. If a repo has no CI, the Product go must say `no CI`.

A new head SHA or any HIGH+ finding voids the go and the Review approval. (The Vessy agent `bc-af7a996c` exception in [../common/models-and-usage.md](../common/models-and-usage.md) Exceptions applies to this voiding rule too.)

**Method:** Squash-merge pinned to the head SHA where squash-merge is allowed; otherwise a merge commit (e.g. Ped). Then post the merge SHA in the project room.

**Needs Pier's explicit OK in DM:** anything touching payments (e.g. Stripe), secrets or keys or signing, or DB changes that delete data.

**Auto-deploy projects (e.g. Vaya on Vercel):** Product checks the live site after each merge. Vaya live check = Vercel status green + HTTP 200.

## UpdateAgent snippet

```
Wake: Pier or Grok Coord → Product; Product → Code with a concrete brief.
Review wakes only on open PR / preview ask — no mutual all-wake fan-out.
Jobs/Leads → Product for go/no-go; no live apply without Product/Pier OK.
Merge: Coord (1st) or Product (2nd) after Review approve + CI green + Product go; squash where allowed, else merge commit; no drafts.
Models: small composer-2.5 low fast off; medium/long grok-4.7; Other Models only with Product justification + Pier DM OK; expensive actions only after Pier's explicit yes; one agent per PR. See common/models-and-usage.md.
```

## Anti-pattern

Product waking Review "just in case", Review waking Code to "fix while I look", Jobs waking Code directly, or Code waking Product for every commit status. Use one handoff message with a clear ask instead.
