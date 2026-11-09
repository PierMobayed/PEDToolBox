# Access map — Ped Product

Where things are kept. **Names and places only, never values.** Public repo: no private URLs, keys, tokens or IPs.

| What | Where |
|---|---|
| Product repo | PierMobayed/PEDToolBox (public), product branch `v3`; `Tool` = old v1 |
| Clone on Pier's PC | `C:\Pier\projects\PEDToolBox` (junction `C:\Pier\PEDToolBox` also works); reached through machine Shell (PowerShell) |
| Fleet rules snapshot | `.repo-rules/` inside the clone (gitignored, local only); refresh with `/up rules` (repo-rules `scripts\sync-rules.ps1 -Only ped -Public` from the local repo-rules checkout `C:\Pier\projects\repo-rules`) |
| Release builds | `C:\Pier\releases\ped\<version>\` on Pier's PC (T053); published only as GitHub Releases |
| Security write-ups | `C:\Pier\threats\pedtoolbox\` on Pier's PC only (location only; never in git or chat) |
| Saved cloud-agent briefs | `C:\Pier\orgGrokBots\briefs\<YYYY-MM-DD>_<repo>_<bc-id 8 hex>.md` |
| Secrets map | Pier's private keys repo (appkeys), file `pedtoolbox/SECRETS-MAP.md` — names and paths only; I never read or touch values |
| Store submission pack | `docs/guides/store/` (LISTING, PRIVACY, SCREENSHOTS, AGE-RATING, PIER-CHECKLIST) |
| Task plans / archived briefs | `docs/architecture/plans/<ID>.md` / `docs/archive/briefs/<ID>.md` |
| Release notes | `docs/releases/CHANGELOG.md`, `docs/releases/RELEASING.md` |
| GitHub tools | GitHub connector (read PRs, diffs, checks) and `gh` on Pier's PC |
