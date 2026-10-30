# Privacy policy — PED Toolbox (Microsoft Store)

**Status as of 2026-10-30**

This text describes **PED Toolbox v3** as shipped in source on branch `v3`. It is not legal advice.

**Partner Center URL (public blob on `v3`):**

https://github.com/PierMobayed/PEDToolBox/blob/v3/docs/guides/store/PRIVACY.md

You may later mirror the same file via GitHub Pages if Partner Center requires HTTPS on a custom domain.

## Summary

PED Toolbox is a **local** Windows maintenance app. It does **not** send usage analytics, crash reports, or personal data to the developer. It does **not** include third-party advertising or tracking SDKs.

## Data the app processes

| Data | Purpose | Leaves the device? |
|---|---|---|
| **Activity log** (in-memory + optional file) | Shows what the app did in the UI | **No** — stored under `%LocalAppData%\PEDToolbox\logs\` on the user's PC only |
| **System information** (WMI, volumes, installed apps) | Display on Home / Diagnostics / Apps pages | **No** — read for display; not uploaded |
| **Registry and file changes** from user actions | Privacy toggles, cleanup, services, restore, etc. | **No** — local Windows configuration only |
| **winget CLI** (search/install/upgrade) | Apps page when the user runs winget | **Yes** — to **Microsoft's winget sources** (App Installer / configured sources), not to PierMobayed |
| **External browser** | Diagnostics link opens `https://fast.com` in the default browser **only when the user clicks the link** | **Yes** — user-initiated; Fast.com's policy applies |

## Network use

- The app **does not** open HTTP/HTTPS connections to `github.com`, `pedtoolbox.com`, or any developer server for telemetry or licensing.
- **winget** may download package metadata and installers from Microsoft/community sources when the user uses the Apps page.
- **About** and **Home** may show static URLs (GitHub, project site) as text; opening them uses the user's browser only if they choose.

## Telemetry and logging

- No Application Insights, Sentry, or similar in the v3 codebase.
- The **Privacy** page can change **Windows** telemetry-related policies (registry) when the user applies toggles — that is local OS configuration, not transmission to the developer.
- Local log files are plain text on disk; the user can delete them under `%LocalAppData%\PEDToolbox\`.

## Children and accounts

The app does not create online accounts and does not knowingly collect children's data. [Pier decides] age rating and Store age band after IARC questionnaire — see [AGE-RATING.md](AGE-RATING.md).

## Contact

Questions: https://github.com/PierMobayed/PEDToolBox/issues

## Changes

Product updates this file when network, logging, or data collection behavior changes in a release.
