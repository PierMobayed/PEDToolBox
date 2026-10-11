# T048 — Microsoft Store / Partner Center account

**Status:** todo  
**Owner:** Pier  
**Part of:** 3.2 "да може да се инсталира"

## Goal

Create the Microsoft Store / Partner Center individual developer account so MSIX can be submitted and Store-signed.

## Context

Decision: Pier, 2026-10-12 — Ped will be signed through a free Microsoft Store individual developer account using MSIX. Microsoft re-signs the package after certification, so there is no SmartScreen warning. No paid code-signing certificate for now.

## Steps

1. Go to [storedeveloper.microsoft.com](https://storedeveloper.microsoft.com)
2. Register as an individual developer (free, requires ID + selfie)
3. Share the Store-assigned publisher name (CN) for the MSIX manifest

## Unblocks

- **T032-3** (signed MSIX → Partner Center)
- Later winget via `msstore` source (after the app is in the Store)
