# T048 — Microsoft Store / Partner Center account

**Status as of 2026-10-30**


**Status:** next  
**Owner:** Pier  
**Part of:** 3.2 "да може да се инсталира"

## Goal

Create the Microsoft Store / Partner Center individual developer account so MSIX can be submitted and Store-signed.

Decision: Pier, 2026-10-12 — Ped will be signed through a free Microsoft Store individual developer account using MSIX. Microsoft re-signs the package after certification, so there is no SmartScreen warning. No paid code-signing certificate for now.

Steps:

1. Go to [storedeveloper.microsoft.com](https://storedeveloper.microsoft.com)
2. Register as an individual developer (free, requires ID + selfie)
3. Share the Store-assigned publisher name (CN) for the MSIX manifest

Unblocks **T032-3** (signed MSIX → Partner Center) and later winget via `msstore` source (after the app is in the Store).

## Done

none yet

## Still waiting

Pier: account creation and publisher CN for the manifest.

## Do not

- Bots must not register the Store account in Pier's name or handle Pier's ID/selfie flow.
- Never commit `.pfx` or Store secrets to the repo.
- No MSIX Partner Center submit before T048 completes.
- No merge without Review + Product go.
