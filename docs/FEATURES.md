# Features (v3.0.0)

Every action is user-initiated. Destructive ones show a confirm dialog. Results go to the Activity log.

| Page | What happens | Admin |
|---|---|---|
| Home | WMI snapshot: OS, CPU, RAM, disk, uptime | no |
| Restore & backup | List/create restore points (`SystemRestore`). Opens `SystemPropertiesProtection.exe` | create: yes |
| Diagnostics | Same snapshot + volumes. Links: msinfo32, fast.com | no |
| Repair & updates | Settings URI for Windows Update / Windows Security. Confirmed `sfc /scannow` and `dism /RestoreHealth` | yes for SFC/DISM |
| Privacy | Advertising ID (HKCU). Telemetry policy + activity history (HKLM) | HKLM: yes |
| Apps | `winget search/install/upgrade`. Uninstall via registry UninstallString | install may UAC |
| Startup & junk | Enumerate/delete Run keys. Delete user TEMP (top-level). Empty Recycle Bin. Launch cleanmgr | HKLM Run: yes |
| Services | Load JSON profiles, show live `ServiceController` status, `sc config start=` | apply: yes |
| System toggles | `powercfg` hibernate / Ultimate Performance, `sc` WSearch | yes |
| Activity log | In-memory copy of the file log | no |
| About | Version, links, distribution notes | no |

## Not in 3.0.0 (still v1-only)

- Bundled BleachBit / Glary / Wise / Revo / OOAppBuster
- Driver packs / Rufus / Ventoy / Windows ISO generator
- One-click “turbo” besides the JSON service profiles
- Task Scheduler bulk editor
- Start menu layout backup
- Wi-Fi password dump
- Account password reset from WinRE

See `ROADMAP.md`.
