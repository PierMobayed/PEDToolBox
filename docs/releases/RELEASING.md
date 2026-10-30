# Releasing

**Status as of 2026-10-30**

How we ship a new **version** of PED Toolbox to users. No passwords, keys, or signing files belong in this repo or in these steps.

**Decision:** Pier, 2026-10-11 — releases run on Pier’s PC through **machine Shell** (remote shell on that machine), executed by the **Ped Release** bot. The bridge hub and a local Cursor session on Pier’s PC are **no longer** used for releases.

## Who does what

| Role | Responsibility |
|---|---|
| Ped Code | Opens the **release PR** on `v3` (version bump, notes, any packaging fixes) |
| Ped Review | Reviews the PR (diff, `asInvoker`, Store/MSIX, winget YAML, secrets, no accidental `Tool` / v1 overwrites) |
| Ped Product | **Go** with PR number and approved **head SHA** |
| Grok Coord | Merges after the merge gate; Ped Product merges only if Coord is unavailable |
| Ped Release | Woken with **version**, merge **SHA**, and approved **head SHA**; builds and publishes on Pier’s PC |

Nobody pushes to `v3` directly.

## Merge gate (release PR and all PRs)

Before merge: **Ped Review** approves the **latest head SHA**; **CI** is green on that SHA; **Ped Product** gives a **go** naming PR **#** and **head SHA**. Any push after the go needs a new Review approve and a new Product go. PRs touching secrets/keys/signing/payments/DB deletes (including MSIX/Store signing) also need **Pier’s explicit OK in DM**. **Grok Coord** merges (Ped Product fallback only if Coord is unavailable). See [TEAM.md](../guides/TEAM.md).

## End-to-end flow

1. **Release PR** on `v3` (code + in-PR doc updates for the change).
2. Pass the **merge gate** (Review on latest SHA, green CI, Product go with PR # + SHA; Pier DM if signing/secrets scope).
3. **Grok Coord** merges (or Ped Product if Coord is unavailable).
4. **Wake Ped Release** with: version string, merge commit SHA, approved PR head SHA.
5. On **Pier’s PC** (machine Shell):
   - `git` checkout the merge SHA on `v3`.
   - Build the release zip per [PACKAGING.md](../guides/PACKAGING.md) (today: `.\packaging\pack-release.ps1 -SelfContained` from the repo root).
   - Create a **GitHub Release** on `v3` tagged `vX.Y.Z` with **only** the app zip as an asset (not the source tree). See [DOWNLOAD.md](../guides/DOWNLOAD.md).
6. **Record evidence** in [CHANGELOG.md](CHANGELOG.md) and [HISTORY.md](../HISTORY.md) (newest first): version, date, release URL, build SHA, artifact **SHA256** and **size**, what was intentionally not done, and effect on open P0 risks (e.g. `R-2 unchanged`).
7. **Follow-up docs PR** after the release if anything still needs documenting.

Signing material (`.pfx`, Partner Center secrets) stays **off** the repo and off GitHub; Store upload uses Pier’s account only.

## Local folders on Pier’s PC (not in git)

| Path | Purpose |
|---|---|
| `<clone>/artifacts/` | Build output from `pack-release.ps1` (zip + `SHA256.txt`). Listed in `.gitignore`. |
| `C:\Pier\releases\ped\<version>\` | **Canonical local release copy** on Pier’s PC after a build (e.g. `PEDToolbox-X.Y.Z-win-x64.zip`; optional `backup\` per fleet release rule). **Not** in the repo. |
| `<clone>/release/` | Legacy path; still in `.gitignore`. Do not use for new releases — use `C:\Pier\releases\ped\<version>\` instead. |

Do **not** commit zips from `artifacts/` or release folders. Publish them **only** as GitHub Release assets (`gh release create …` attaching the zip).

## Build checklist (matches PACKAGING + DOWNLOAD)

1. Run `pack-release.ps1` with the intended flags (`-SelfContained` for a zero-runtime zip, or framework-dependent when [T033-1](../architecture/plans/T033-1-light-installer.md) is the default).
2. Confirm `artifacts\SHA256.txt` matches the zip you will upload.
3. Copy the zip you will ship into `C:\Pier\releases\ped\<version>\`.
4. `gh release create vX.Y.Z` (or equivalent) attaching **only** that zip — **never** commit it to `v3`.
5. Release notes: first link is the **direct download** URL (`…/releases/download/vX.Y.Z/…`), plus one line that source is branch `v3`, not the Release zip.
6. Update README download link if the version changed.

## Known blockers (see [RISKS.md](../guides/RISKS.md))

| Id | Issue |
|---|---|
| T049 | `pack-release.ps1` still names zips `3.1.0` — fix before the next release |
| T048 / [T032-3](../architecture/plans/T032-3-msix-partner-center.md) | Partner Center account and Store signing path — MSIX/Store releases wait on Pier |

Winget manifest updates after a Release: manual PR to `microsoft/winget-pkgs` until [T033-2](../architecture/plans/T033-2-winget-github-action.md); first package [PR #442279](https://github.com/microsoft/winget-pkgs/pull/442279) must merge before `winget install PED.Toolbox` works. **Opening any winget-pkgs PR always needs Pier’s explicit OK** before Ped Release (or anyone) submits it.
