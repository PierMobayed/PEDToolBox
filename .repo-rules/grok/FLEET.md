# Pier's Grok Bot fleet

**Updated:** 2026-10-16  
**Maintainers:** Org Desk → Grok Coord (inspect with Pier)

See also: [local-cursor.md](./local-cursor.md) — Local Cursor Agent on Pier's PC (messaging; fallback path when machine Shell is unavailable, only with Coord's go; appkeys backups). Not `gh release create` / signed builds for any project.

## Grok Coord

Coordinator of the fleet. Main job: talk to **Product** bots (Liko / Ped / Vaya / SetupAI / naChas / VesiTV) — whether they are doing their work — and route Pier's asks:

| From | To |
|------|-----|
| Pier or Grok Coord | Product (scope, docs, priority) |
| Product | Code (concrete coding brief) |
| open PR / preview ask | Review |
| Jobs / Leads shortlists | Product (go/no-go) |

Coord does **not** write product app code. Delegates. Bulgarian with Pier; English OK for tech.

## Projects × canonical repos

| Project | Repo | Notes |
|---------|------|--------|
| Ped Toolbox v3 | https://github.com/PierMobayed/PEDToolBox (`v3`) | Not `PEDTool` |
| Liko TV | https://github.com/PierMobayed/likotv | Not `likot` |
| Vaya | https://github.com/PierMobayed/vaya.bg | |
| SetupAI | https://github.com/PierMobayed/setupAI (`main`) | No Release bot |
| naChas | https://github.com/PierMobayed/beatSmartPrice (`main`) | Repo is `beatSmartPrice`; not `nachas` / `na-chas` |
| VesiTV | https://github.com/PierMobayed/tv1 (`main`) | Repo is `tv1`; not `vesitv`. Separate from Liko TV (`likotv`) |
| Bridge | PierMobayed/pm-bridge-system | Bridge Product is Product owner; merge rule applies (`pm-bridge-system`) |

## Role map

| Role | Ped | Liko | Vaya | SetupAI | naChas | VesiTV | Bridge |
|------|-----|------|------|---------|--------|--------|--------|
| Product | Ped Product | Liko Product | Vaya Product | SetupAI Product | naChas Product | VesiTV Product | Bridge Product |
| Code | Ped Code | Liko Code | Vaya Code | SetupAI Code | naChas Code | VesiTV Code | Bridge Code |
| Review | Ped Review | Liko Review | Vaya Review | SetupAI Review | naChas Review | VesiTV Review | Bridge Review |
| Release | **Ped Release** | — (Play = Pier) | — (Vercel/ops = Pier) | — (none) | **naChas Release** | **VesiTV Release** | Bridge Release (planned) |
| Jobs | — | — | — | SetupAI Jobs | — | — | — |
| Leads | — | — | — | SetupAI Leads | — | — | — |
| HR (bot factory) | HR Desk (shared) | HR Desk (shared) | HR Desk (shared) | HR Desk (shared) | HR Desk (shared) | HR Desk (shared) | HR Desk (shared) |

Also: **Grok Coord**, **Org Desk** (fleet org only), **HR Desk** (`b35fa9ac-dbfc-4d6d-a156-4a31e5c4b245` — bot design and maintenance for every project; SetupAI achievement scoring; not seated in any room), **Bridge Product** (`f667a085-0e14-4929-825b-13efcf34ca16` — Product owner of `pm-bridge-system`), **Bridge Code** (`b90af1d8-88cd-4bbc-ab41-295c4c7e79c4`), **Bridge Review** (`7383724f-047b-4ddd-abc9-b119770db175`), **Bridge** (`c56de20c-ba74-4b3a-8f9e-00e8c92f2800` — Grok Coord, Bridge Product, Bridge Code, Bridge Review), **Bridge Night** (`ed28ba67-a28a-4a10-898b-2474d93fee55` — overnight queue for already-approved bridge jobs; members Bridge Product + Grok Coord), **[Local Cursor Agent](./local-cursor.md)** (Pier's PC — fallback path plus appkeys backups).

## Wake rules (no mutual fan-out)

See [wake-rules.md](./wake-rules.md).

Short form: Pier/Coord → Product → Code. Review only on open PR / preview. Jobs/Leads → Product for go/no-go. No all-wake fan-out.

SetupAI rooms: **Build** for Product/Code/Review; **Ops** for Product/Jobs/Leads. Cross-room asks still go through Product or Coord — no mutual fan-out.

**Grok chats:** new task = new conversation with the same bot (do not delete or duplicate the bot). Wrap-up goes in the project's `docs/STATUS.md`. Routine with no new work is not woken. Bridge Night sends a morning summary only if an approved job ran overnight.

## Merge rule

See [../common/merge-rule.md](../common/merge-rule.md).

Short form: **Grok Coord** merges PRs (first choice); **Product** merges if Coord unavailable. Code and Review never merge. Applies to naChas/beatSmartPrice, Vaya, Liko TV, PED Toolbox, SetupAI, VesiTV/tv1, **pm-bridge-system**. Requires Review approve + CI green + Product go (naming PR # and head SHA). A COMMENT/channel OK counts only with the full 40-character head SHA. No draft PRs. **CI green** = every check run passed; if the repo has no CI, the go must say `no CI`. A new head SHA or any HIGH+ finding voids the go and approval (Vessy `bc-af7a996c` exception applies — see [../common/models-and-usage.md](../common/models-and-usage.md)). Squash-merge where allowed, otherwise a merge commit (e.g. Ped); post merge SHA in project room. Payments, secrets/keys/signing, or DB deletes need Pier's explicit OK in DM. Auto-deploy projects: Product checks live site after merge (Vaya = Vercel status green + HTTP 200). main is unprotected (R-3): Review bots flag commits that landed on main without a PR.

## Models & usage

See [../common/models-and-usage.md](../common/models-and-usage.md).

Short form: small tasks `composer-2.5` low, fast off; medium/long `grok-4.7`; Other Models only with Product justification + Pier DM OK; expensive actions (browser/screenshots/computerUse/media) only after Pier's explicit yes; one cloud agent per PR; local worker `laptop` when online.

## Documentation

See [../common/docs-rules.md](../common/docs-rules.md). Fleet-wide files, id scheme, and shipped vs unreleased. Projects may be stricter than the shared rules (e.g. Vaya migrations). Cloud agents need only the project repo (committed `.repo-rules/` snapshot). Briefs paste relevant task lines; they do not attach this rules repo as a second env.

## Release policy

See [release-roles.md](./release-roles.md). Signing keys: [../common/signing-keys.md](../common/signing-keys.md).

- Ped Release stays — machine Shell on Pier's PC (same pattern as naChas Release and VesiTV Release).
- naChas Release stays — machine Shell.
- VesiTV Release stays — machine Shell.
- Machine-Shell Release bots: naChas, VesiTV, Ped. PM Bridge / Local Cursor Agent do not handle releases for any project.
- Releases build from the merge SHA on the product branch (Ped = `v3`). Product may give the Release go if Coord is unavailable.
- **Do not** create Liko Release, Vaya Release, or SetupAI Release.

## Channels

See [channels.md](./channels.md).

| Channel | id | Members (no Org Desk) |
|---------|-----|------------------------|
| Liko | `f2b5431f-27f5-41fb-b8e4-f9bb4bfd9914` | Product, Code, Review, Coord |
| Ped | `25a956de-dfc8-4655-a941-d00b203eef2d` | Product, Code, Review, Release, Coord |
| Vaya | `9d76d93c-f13a-4c7e-8133-2e718b57f163` | Product, Code, Review, Coord |
| SetupAI Build | `4006b83a-ee61-43e0-9d90-0a70ac3a8866` | Product, Code, Review, Coord |
| SetupAI Ops | `f890fa78-5fc0-468e-afe2-3b5f2a1df67d` | Product, Jobs, Leads, Coord |
| naChas | `b15cc665-d58d-4335-a58d-91d8b03d0664` | Product, Code, Review, Release, Coord |
| VesiTV | `e3c74d5c-4a7e-4083-b913-599dc4e0df0d` | Product, Code, Review, Release, Coord |
| Bridge | `c56de20c-ba74-4b3a-8f9e-00e8c92f2800` | Bridge Product, Bridge Code, Bridge Review, Grok Coord |
| Bridge Night | `ed28ba67-a28a-4a10-898b-2474d93fee55` | Bridge Product, Grok Coord |

**Deprecated:** old SetupAI `6ffd9ea6-30f9-4eb2-a0ba-5452a6cc3d65` — delete from sidebar.

**Bridge** (`c56de20c-ba74-4b3a-8f9e-00e8c92f2800`): project room. Members: Grok Coord, Bridge Product, Bridge Code, Bridge Review. Bridge Product is seated here and in Bridge Night.

**Bridge Night** (`ed28ba67-a28a-4a10-898b-2474d93fee55`): overnight queue for bridge jobs that are already approved. Members: Bridge Product and Grok Coord. Sends a morning summary to Coord; never publishes, merges, or touches secrets. Do not delete.

## naChas

**Status:** active — bots and channel created.

**App:** "На час" v1.8.4 — Android app (package `app.nachas.hourly`) + Next.js PWA calculator. Helps Uber drivers in the UK see net £/hour for each offer.

**Product context:** Pier is the only user; the app is not public until an ad bar and a translation land.

**Bots:**
- naChas Product (`681d1ccc-8520-4b4a-82e2-28752e897f86`) — project product manager (docs, priorities, risk, go/no-go)
- naChas Code (`c43d817d-4882-434e-8c4a-149054b8f078`) — Cursor cloud agent (works on a branch + opens PR)
- naChas Review (`3efc3e5a-9273-4df6-b139-3dba1b7d43eb`) — wakes only on an open PR
- naChas Release (`72218f2e-9242-4df7-a8ae-7fd82f31ddc7`) — builds, signs, and publishes APKs on Pier's PC via the machine Shell

**Architect:** Cursor cloud agent `bc-4e8c178b-4920-4f0e-8444-05ea7351ff77` ([dashboard](https://cursor.com/agents/bc-4e8c178b-4920-4f0e-8444-05ea7351ff77)). Pier named it naChas's main architect; it built the app up to v1.8.4. Advisory role: keeps the app's design intact (the formula, the tabs, the overlay). Does not push to main; code still goes Product → naChas Code → PR → Review → merge (see [Merge rule](../common/merge-rule.md)).

**Release:** naChas Release builds, signs, and publishes APKs on Pier's PC via the machine Shell (skill `nachas-release-build`, runbook `/workspace/nachas/release/RUNBOOK.md`) from the merge SHA on `main`. Woken by Grok Coord or naChas Product after merge (Review approved, CI green, Product go). Product may give the Release go if Coord is unavailable. Not the PM Bridge / Local Cursor Agent path.

**Wake chain:** Pier/Coord → Product → Code. Review only on open PR. Misses go back to Product; no fan-out.

**Live actions:** publishing an APK, Play billing, anything driver-facing (user-visible app changes for the driver) — need Product + Pier OK. **Exception (2026-10-08):** releases run by the machine-Shell Release bots (**naChas Release**, **VesiTV Release**, **Ped Release**) — Grok Coord may give the publish go after verifying the merge SHA on the product branch, cert match, and no real AdMob IDs. Product may give the Release go if Coord is unavailable. The Local Cursor Agent does not run naChas (or any) releases.

### ⚠️ Non-authoritative doc in beatSmartPrice

The file `docs/grok-bots.md` in the beatSmartPrice repo (written by the same cloud agent, `bc-4e8c178b`) is **NOT adopted**. It invents a second "grok coord" plus Builder/Reviewer/Release bots across 3 chats — this structure does not follow fleet rules. (The agent is trusted for **app design**; this fleet-structure doc is a separate matter.)

**This grokbotsrules definition is the source of truth.** That file will be replaced by a short pointer to grokbotsrules, done via a naChas Code PR.

## VesiTV

**Status:** active — bots and channel created.

**App:** VesiTV — local Python server + web UI + Android TV APK. Sideload/lab product. Canonical repo is `PierMobayed/tv1` (`main`); repo name is `tv1`, not `vesitv`. Separate from the Liko TV store fork (`PierMobayed/likotv`).

**Bots:**
- VesiTV Product (`50da0d12-edf0-48f1-ae48-a71449f66d2e`) — project product manager (docs, priorities, risk, go/no-go)
- VesiTV Code (`c8d33a42-be4b-4f88-ae2c-8951f2149d8a`) — Cursor cloud agent (works on a branch + opens PR)
- VesiTV Review (`9b64af2b-df8e-4315-b8b6-e59524994b02`) — wakes only on an open PR
- VesiTV Release (`0523f7f0-3b90-4197-ae05-bc64001e2a27`) — builds, signs, and publishes the Android TV APK on Pier's PC via the machine Shell

**Release:** VesiTV Release builds, signs, and publishes the Android TV APK on Pier's PC via the machine Shell (same pattern as naChas Release) from the merge SHA on `main`. Woken by Grok Coord or VesiTV Product after merge (Review approved, CI green, Product go). Product may give the Release go if Coord is unavailable. Not the PM Bridge / Local Cursor Agent path.

**Wake chain:** Pier/Coord → Product → Code. Review only on open PR. Misses go back to Product; no fan-out.

**Merge / models:** standard fleet merge rule and models rule apply.

## Vaya

**Docs:** Vaya follows the shared [../common/docs-rules.md](../common/docs-rules.md) like other projects. Vaya Product first checks for conflicts with Vaya's own rules (migrations, business model) and shows Pier any conflict before changing anything. The transition is a separate docs-only PR in `vaya.bg`. `TASKS.md` counts as BACKLOG.

**Live check after merge:** Vercel status green + HTTP 200.

## Ped

**Release:** Ped Release (`abb1ca0c-e8e7-4e4d-ae59-cfc8211cfeee`) builds and publishes via the machine Shell on Pier's PC (GitHub Releases / winget / MSIX for `PierMobayed/PEDToolBox`) from the merge SHA on `v3`, same pattern as naChas Release and VesiTV Release. Woken by Grok Coord or Ped Product after merge (Review approved, CI green, Product go). Product may give the Release go if Coord is unavailable. Not the PM Bridge / Local Cursor Agent path. Merge method: merge commit (squash not used).

## Bridge (`PierMobayed/pm-bridge-system`)

**Bridge Product** (`f667a085-0e14-4929-825b-13efcf34ca16`) is the Product owner of `pm-bridge-system`: docs, backlog, briefs, Product go.

**Bridge Code** (`b90af1d8-88cd-4bbc-ab41-295c4c7e79c4`) writes and lands code via one cheap cloud agent per PR.

**Bridge Review** (`7383724f-047b-4ddd-abc9-b119770db175`) reviews `pm-bridge-system` PRs (replaces Ped Review for bridge PRs). **Grok Coord** merges.

BR-1 (`pm-bridge-system` PR #10) merged as `1ad6c3a`.

**Bridge** (`c56de20c-ba74-4b3a-8f9e-00e8c92f2800`): Grok Coord, Bridge Product, Bridge Code, Bridge Review. Bridge Product is seated in Bridge and Bridge Night.

**Bridge Night** (`ed28ba67-a28a-4a10-898b-2474d93fee55`) is the overnight queue for bridge jobs that are already approved. Members: Bridge Product and Grok Coord. Sends a morning summary to Coord; never publishes, merges, or touches secrets.

Merge rule includes **pm-bridge-system**.

## Onboarding a new bot

Whoever creates a bot (HR Desk or Grok Coord) sends it this as its very first message, and the new bot does it once:

> "Сложи си нов аватар: анимирано човече с уникално лице, подходящо за ролята ти и проекта. Част си от семейството на групата."
> (English: "Set yourself a new avatar: an animated character with a unique face, suited to your role and project. You are part of the group's family.")

Guidelines for the new bot:
- Same animated cartoon style as the rest of the project's team, but a different face, hair, glasses and background colour from every other bot in that room.
- Hold a role prop (e.g. checklist for Product, laptop for Code, magnifying glass for Review, package or rocket for Release, clipboard with people for HR) and include one shared project symbol (e.g. a TV with a Play button for VesiTV).
- Generate one image, at most two. Don't iterate. No real people, no logos. Afterwards post a one-line description of the avatar in the project room.
- This is a one-time onboarding exception to rule 9 (models-and-usage.md), pre-approved by Pier. Any other image generation still needs Pier's explicit yes.

## Audit table

Full table: [fleet-audit-table.md](./fleet-audit-table.md).
