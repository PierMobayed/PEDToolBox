# Signing keys and appkeys

**Updated:** 2026-10-16 (Pier-approved via Grok Coord)  
**Owner:** Org Desk (inspected by Grok Coord + Pier)

Every app's signing keys/keystores are backed up in the private repo `PierMobayed/appkeys`, one folder per project (`nachas/`, `likotv/`, `vesitv/`, and `ped/`, `setupai/`, `vaya/` etc. added as needed). Pier wants them all collected there first; he will decide later where they finally live.

- Never delete, overwrite, or move anything already in appkeys.
- Passwords are never in plain text; they go only in the encrypted password archive, as done for `nachas/`.
- No keys, keystores, or passwords in project repos or docs.
- Only Pier, or a bot acting on Pier's explicit ask on his PC (machine Shell), uploads keys. Cloud agents never touch key files.

**Workspace (Pier, 2026-10-16):** a local worker is allowed (saves a Cursor VM and git pulls, eases builds). **Appkeys and passwords must live outside the agent's workspace.** Do not add `appkeys` (or any keystore/password folder) as a workspace root, extra repo, or readable mount for a cloud or local agent. The agent may be told key **names** only.

Release who-does-what: [../grok/release-roles.md](../grok/release-roles.md). Local Cursor messaging / fallback: [../grok/local-cursor.md](../grok/local-cursor.md).
