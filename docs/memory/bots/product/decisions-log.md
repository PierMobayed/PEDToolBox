# Decisions log — Ped Product

Dated decisions, who decided, why; newest first. Project-level decisions are mirrored in [docs/DECISIONS.md](../../../DECISIONS.md).

- 2026-11-09 — Docs/memory refresh by direct commits to `v3` under `docs/` (no PR). Who: Pier via Coord. Why: docs-only, saves tokens.
- 2026-11-09 — Old flat `docs/memory/bots/product.md` template moved to `docs/memory/bots/templates/product.md` (same path as open PR #16) instead of the archive: it held no notes, only the template. Who: Ped Product. Why: templates folder is the fleet location; keeps #16 mergeable.
- 2026-10-30 — #12 closed unmerged and re-cut as #13; #14 closed unmerged and re-cut as #15. Who: Ped Product (with Coord). Why: squash disabled, and a merge commit would have published a private URL from branch history.
- 2026-10-30 — T051 .NET 10 row added (deadline .NET 8 EOL 2026-11-10), incl. System.Management / ServiceController bumps and `permissions: contents: read` in build.yml. Who: Ped Product, from Org Desk LOW/INFO hygiene findings. Why: security support ends.
- 2026-10-30 — Task detail files moved from `docs/guides/tasks/` to `docs/architecture/plans/` (T054, PR #15). Who: Ped Product (Pier: follow the rules). Why: docs-rules rule 9.
- 2026-10-30 — Secret scanning, push protection, Dependabot ON. Who: Pier (done by Coord). Why: public repo.
- 2026-10-30 — T053 release folder `C:\Pier\releases\ped\<version>\` supersedes T050 in-clone `release/`. Who: Pier (fleet release rules). Why: one folder per version outside the clone.
- 2026-10-27 — T048 Store submission pack as a docs PR (listing, privacy, screenshots, age rating, Pier checklist). Who: Pier OK via Coord. Why: Pier only creates the account and clicks.
- 2026-10-27 — Versioning rule. Who: Pier. Why: never change a built version.
- 2026-10-12 — Free Microsoft Store individual account + MSIX; no paid code-signing certificate. Who: Pier. Why: no cost; Store re-signs.
- 2026-10-11 — Releases on Pier's PC via machine Shell by Ped Release. Who: Pier. Why: same as naChas.
