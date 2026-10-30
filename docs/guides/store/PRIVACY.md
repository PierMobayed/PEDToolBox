# Privacy policy — PED Toolbox (Microsoft Store)

**Status as of 2026-10-30**

This text describes **PED Toolbox v3** (including the **Store SKU** built with `-p:StoreSku=true`) as on branch `v3`. It is not legal advice.

**Partner Center URL (public blob on `v3`):**

https://github.com/PierMobayed/PEDToolBox/blob/v3/docs/guides/store/PRIVACY.md

You may later mirror the same file via GitHub Pages if Partner Center requires HTTPS on a custom domain.

## Summary

PED Toolbox is a **local** Windows maintenance app. It does **not** send usage analytics, crash reports, or personal data to the developer. It does **not** include third-party advertising or tracking SDKs.

## Activity log

Every logged action is written to a **daily log file** on disk (in addition to the in-app Activity log view):

`%LocalAppData%\PEDToolbox\logs\ped-YYYYMMDD.log`

The app creates that folder if needed. Logs stay on the user's PC only and are never uploaded by PED Toolbox.

## PED-Recovery backup

When the user creates a **PED-Recovery snapshot**, files are written under **`%SystemDrive%\PED-Recovery\<timestamp>\`** (for example `C:\PED-Recovery\…`) when that path is writable. If not, the app uses **`%LocalAppData%\PEDToolbox\PED-Recovery\<timestamp>\`** instead. Those folders hold registry exports, restore scripts, and related backup files. They may include **`winKey.txt`**, which contains the Windows product key if Windows stored one for backup. All of this stays **local only** and is **never sent** to the developer or any PED Toolbox server.

## Data the app processes

| Data | Purpose | Leaves the device? |
|---|---|---|
| **Activity log file** (always written) | Record of actions the app performed | **No** — `%LocalAppData%\PEDToolbox\logs\` only |
| **PED-Recovery backup** | User-initiated snapshot (see paths above) | **No** — local disk only (may include product key in `winKey.txt`) |
| **System information** (WMI, volumes, installed apps) | Display on Home / Diagnostics / Apps pages | **No** — read for display; not uploaded |
| **Registry and file changes** from user actions | Privacy toggles, cleanup, restore, etc. | **No** — local Windows configuration only |
| **winget CLI** (search/install/upgrade) | Apps page when the user runs winget | **Yes** — to **Microsoft's winget sources** (App Installer / configured sources), not to the developer |
| **DISM RestoreHealth** | Windows component repair (Repair page, user-confirmed) | **Yes** — may use the **internet** (Microsoft component store), as in the app prompt |
| **DISM driver export** (optional backup step) | Exports drivers into the PED-Recovery folder | **No** — **offline** export to local disk only |
| **User-opened links** | Diagnostics **fast.com**; About **Website** (`https://pedtoolbox.com`), **GitHub** (`https://github.com/PierMobayed/PEDToolBox`), **Email** (`pedtoolbox@gmail.com`) | **Yes** — **only when the user clicks**; opens the default browser or mail client |

## Network use

- PED Toolbox **does not** call the developer's servers for telemetry, licensing, or automatic updates in v3.
- **winget** may download package metadata and installers when the user uses the Apps page.
- **DISM RestoreHealth** may use the internet; optional **driver export** during backup does not.
- **About → Website / GitHub / Email** and **Diagnostics → fast.com** open externally only on user click (see table above).

## Telemetry and logging

- No Application Insights, Sentry, or similar in the v3 codebase.
- The **Privacy** page can change **Windows** telemetry-related policies (registry) when the user applies toggles — local OS configuration, not transmission to the developer.

## Children and accounts

The app does not create online accounts and does not knowingly collect children's data. [Pier decides] age rating and Store age band after IARC questionnaire — see [AGE-RATING.md](AGE-RATING.md).

## Contact

- **GitHub Issues:** https://github.com/PierMobayed/PEDToolBox/issues  
- **Website:** https://pedtoolbox.com (same as About → Website)  
- **Email:** pedtoolbox@gmail.com (same as About → Email)

## Changes

Product updates this file when network, logging, or data collection behavior changes in a release.
