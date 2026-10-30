# Risks

**Status as of 2026-10-12**

Risks use ids `R-n`. **Impact** and **Likelihood** are rough (high / medium / low). **Decision** records who owns the call and whether it is still pending or dated.

## R-1 — No paid code-signing certificate

- **Status:** accepted
- **Impact:** medium (Store and some enterprise policies expect signed installers; the Store **re-signs** the MSIX package after certification, which covers Store distribution but not unsigned GitHub/winget zips)
- **Likelihood:** high until Store path ships
- **Options (not ranked):** buy an Authenticode cert; sign only via Microsoft Store after upload; delay MSIX/Store
- **Blocks:** [T032-3](../architecture/plans/T032-3-msix-partner-center.md) (signed MSIX → Partner Center)
- **Waiting on:** Pier creating the Partner Center account (**T048**) and sharing the Store publisher name
- **Decision:** Pier, 2026-10-12 — ship via the free Microsoft Store individual account and **MSIX** (Microsoft’s packaged app format); Microsoft re-signs after certification; no paid cert for now

## R-2 — Winget catalog PR stuck on external review

- **Status:** open
- **Impact:** medium (`winget install PED.Toolbox` unavailable until the community repo accepts the manifest)
- **Likelihood:** medium (pipeline already passed; human moderator step remains)
- **Options (not ranked):** wait for merge; withdraw and resubmit if moderator requests changes; nudge via winget-pkgs process only
- **Blocks:** [T040](../architecture/plans/T040-v1-winget-ped-run.md) (separate `PED.run` winget package must not race the first `PED.Toolbox` entry)
- **Waiting on:** Microsoft winget-pkgs moderator for [PR #442279](https://github.com/microsoft/winget-pkgs/pull/442279) (`PED.Toolbox`, validated)
- **Decision:** Pier (pending)

## R-3 — Release zip name hardcoded to 3.1.0

- **Status:** open
- **Impact:** high for the next release (wrong artifact name, wrong winget YAML, broken download links)
- **Likelihood:** high if anyone runs `pack-release.ps1` without fixing it
- **Options (not ranked):** single source of truth in **T049** driving `pack-release.ps1`, `src/PedToolbox.App/PedToolbox.App.csproj` (`<Version>`), `packaging/msix/Package.appxmanifest`, and `packaging/winget/*.yaml`; parameterize the script zip name from that
- **Blocks:** next GitHub Release and any winget manifest update tied to that build (**T049**)
- **Evidence:** `packaging/pack-release.ps1` hardcodes `PEDToolbox-3.1.0-…`; version **3.1.0** also lives in `PedToolbox.App.csproj`, the appxmanifest, and winget YAMLs (not in `Directory.Build.props`, which has no `<Version>`)
- **Decision:** Pier (pending)

## R-4 — Self-contained zip is large

- **Status:** open
- **Impact:** medium (slower **winget** — Windows’ command-line package manager — validation; larger downloads)
- **Likelihood:** high for every new winget version while the default artifact stays self-contained
- **Options (not ranked):** framework-dependent zip plus .NET 8 Desktop Runtime; MSIX; keep self-contained only as an optional GitHub asset
- **Blocks:** fast iteration on [T033-1](../architecture/plans/T033-1-light-installer.md) (smaller default installer)
- **Evidence:** 3.1.0 zip **57.8 MB** on GitHub; unpacked ~140 MB ([HISTORY.md](../HISTORY.md), [PACKAGING.md](PACKAGING.md))
- **Decision:** Pier (pending)

## R-5 — Unsigned GitHub / winget zip

- **Status:** open
- **Impact:** medium (**SmartScreen** — Windows’ download warning — and some **antivirus** tools flag unknown unsigned executables; users may hesitate or block the app)
- **Likelihood:** high while GitHub Release and winget ship a zip without Authenticode signing
- **Options (not ranked):** buy a cert and sign the zip/EXE; rely on Store MSIX (Microsoft-signed after certification); document “click More info → Run anyway”; reduce zip-only distribution over time
- **Blocks:** trustworthy first-run experience for zip-only installs; complements R-1
- **Evidence:** [PACKAGING.md](PACKAGING.md) — never commit `.pfx`; 3.1.0 shipped as unsigned self-contained zip
- **Decision:** Pier (pending)

## R-6 — Store may reject or scrutinize a powerful desktop tool

- **Status:** open
- **Impact:** high (no Store listing if certification fails)
- **Likelihood:** medium (toolbox apps use **`runFullTrust`** — full Win32 trust in an MSIX package — and system-changing actions; **`asInvoker`** manifest means admin is opt-in, but reviewers still judge capability)
- **Options (not ranked):** Store SKU without service Apply (`StoreSku`); clear privacy policy and justification text; sideload-only MSIX without Store listing
- **Blocks:** [T032-3](../architecture/plans/T032-3-msix-partner-center.md)
- **Evidence:** [PACKAGING.md](PACKAGING.md), [ARCHITECTURE.md](../architecture/ARCHITECTURE.md)
- **Decision:** Pier (pending)

## R-7 — Publisher CN mismatch in templates

- **Status:** open
- **Impact:** high (MSIX/Store submission fails or cert identity does not match the package)
- **Likelihood:** high until templates are aligned with the real Store identity
- **Options (not ranked):** replace manifest `Publisher` with Store-assigned CN from **T048**; align [PACKAGING.md](PACKAGING.md) table (`CN=PED Toolbox`) with `packaging/msix/Package.appxmanifest` (today `CN=PierMobayed`)
- **Blocks:** [T032-3](../architecture/plans/T032-3-msix-partner-center.md), **T048**
- **Evidence:** `Package.appxmanifest` vs PACKAGING.md publisher CN table
- **Decision:** Pier (pending)

## R-8 — Default branch is `Tool`, product is `v3`

- **Status:** open
- **Impact:** medium (PRs and clones default to v1 batch tree; v3 work can be opened against the wrong branch or reviewed on the wrong tree)
- **Likelihood:** medium while GitHub default remains `Tool` ([T045](../architecture/plans/T045-default-branch.md) not done)
- **Options (not ranked):** flip default to `v3` when ready; enforce branch name in bot prompts; extra Review check for target branch
- **Blocks:** [T045](../architecture/plans/T045-default-branch.md); safe fleet automation on the WPF product
- **Evidence:** repo default branch `Tool`; product README on `v3`
- **Decision:** Pier (pending)
