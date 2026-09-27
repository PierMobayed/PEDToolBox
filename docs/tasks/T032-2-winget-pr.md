# T032-2 — SHA256 + winget-pkgs PR

**Status:** waiting (Microsoft moderator)  
**Part of:** 3.2 “да може да се инсталира”

## Goal

`winget install PED.Toolbox` and `winget install pedtoolbox`.

## Done

- Manifests in `packaging/winget/` (`PED.Toolbox.yaml` + installer + locale)
- SHA256 of the 3.1.0 zip in the installer YAML (`85997DF14A14A97D975C43D511C4D56CE2009EBDB34E6500C05A9A49BABAC35B`)
- PR: https://github.com/microsoft/winget-pkgs/pull/442279
- First validator failure: `ped.run` TCP timeout — PublisherUrl / PackageUrl switched to GitHub / GitHub Pages
- CLA signed (`@microsoft-github-policy-service agree`)
- Automated pipeline **passed** (2026-09-27): labels `Azure-Pipeline-Passed`, `Validation-Completed`, `New-Package`
- Checks including **08. Installation Validation** and **09. Installer Metadata Validation** concluded **SUCCESS**

## Still waiting

- A **community moderator** must approve the PR (bot: “check-in policies require a moderator”). Not blocked on installer re-scan.
- Merge into `microsoft/winget-pkgs` after that review

## Do not

Open a `PED.run` package until this PR is merged or a moderator rejects it with a reason we must fix (T040).
