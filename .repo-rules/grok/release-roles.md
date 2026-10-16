# Release roles (fleet policy)

**Updated:** 2026-10-16  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

## Rule

- **Ped Release** stays (id `abb1ca0c-e8e7-4e4d-ae59-cfc8211cfeee`) — builds and publishes (GitHub Releases / winget / MSIX) for `PierMobayed/PEDToolBox` on Pier's PC via the machine Shell.
- **naChas Release** stays (id `72218f2e-9242-4df7-a8ae-7fd82f31ddc7`) — builds, signs, and publishes naChas APKs on Pier's PC via the machine Shell.
- **VesiTV Release** stays (id `0523f7f0-3b90-4197-ae05-bc64001e2a27`) — builds, signs, and publishes the Android TV APK on Pier's PC via the machine Shell.
- Machine-Shell Release bots: **naChas Release**, **VesiTV Release**, **Ped Release**. The PM Bridge and the [Local Cursor Agent](./local-cursor.md) do **not** handle releases for any project.
- Releases build from the **merge SHA** on the product branch (Ped = `v3`).
- Grok Coord gives the Release go; **Product may give the Release go if Coord is unavailable**.
- **Do NOT create** Liko Release, Vaya Release, or SetupAI Release bots.

## Why

Liko (Play Console), Vaya (Vercel / Cloudflare ops), and SetupAI distribution/ops steps are **operator-only**: Pier holds secrets, store accounts, and final submit. A dedicated Release bot would either sit idle or tempt secret handling.

## Machine Shell (signed builds)

**Ped**, **naChas**, and **VesiTV** releases are done by **Ped Release**, **naChas Release**, and **VesiTV Release** via the machine Shell on Pier's PC (DESKTOP-2AMCEF1) — not Cursor, not PM Bridge. Keystores stay on the PC; APKs leave only as GitHub release assets. See [local-cursor.md](./local-cursor.md) for messaging, the Coord-only fallback if the machine Shell is unavailable, and [../common/signing-keys.md](../common/signing-keys.md) for appkeys backups.

## Signing keys

Canonical text: [../common/signing-keys.md](../common/signing-keys.md).

## Canonical repos

| Project | Repo | Release bot |
|---------|------|-------------|
| Ped Toolbox v3 | `PierMobayed/PEDToolBox` (`v3`) | Ped Release |
| Liko TV | `PierMobayed/likotv` | none (Pier / Play) |
| Vaya | `PierMobayed/vaya.bg` | none (Pier / Vercel) |
| SetupAI | `PierMobayed/setupAI` | none |
| naChas | `PierMobayed/beatSmartPrice` (`main`) | naChas Release |
| VesiTV | `PierMobayed/tv1` (`main`) | VesiTV Release |
| Bridge | `PierMobayed/pm-bridge-system` | Bridge Release (planned, not yet created) — machine Shell, same pattern as Ped Release; the bridge hub will become an installable Windows app; created when the first installable build is near |
