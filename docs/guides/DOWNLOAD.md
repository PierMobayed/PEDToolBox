# Download the program vs the source

**Status as of 2026-10-30**

GitHub always shows **Source code (zip)** / **(tar.gz)** on every Release page. That cannot be turned off on a public repo. Those archives are the git tree, not the app.

We still meet “people should get the program, not the code” by **never putting source in the Release assets** and by linking the binary URL everywhere we say Download.

## Program (what users should get)

Direct file (unzip, run `PEDToolbox.exe`):

https://github.com/PierMobayed/PEDToolBox/releases/download/v3.1.0/PEDToolbox-3.1.0-win-x64.zip

SHA256: `85997DF14A14A97D975C43D511C4D56CE2009EBDB34E6500C05A9A49BABAC35B`

On the [Release page](https://github.com/PierMobayed/PEDToolBox/releases/tag/v3.1.0) click **`PEDToolbox-3.1.0-win-x64.zip` only**. Ignore “Source code”.

Later versions: same pattern — `.../releases/download/vX.Y.Z/PEDToolbox-X.Y.Z-win-x64.zip`. Do not attach `.cs`, `.sln`, or the repo tree as assets.

## Source (optional, separate)

| Want | Use |
|---|---|
| Browse / clone v3 | Branch [`v3`](https://github.com/PierMobayed/PEDToolBox/tree/v3) |
| Zip of the repo | GitHub **Code → Download ZIP** on that branch, or the auto “Source code” links under a tag |
| v1 batch | Branch [`Tool`](https://github.com/PierMobayed/PEDToolBox/tree/Tool) |

## Local copy on Pier’s PC (operators only)

Build output lands in `<clone>/artifacts/` (git-ignored). After build, Ped Release keeps the ship candidate under **`C:\Pier\releases\ped\<version>\`** on Pier’s PC (fleet release rule; replaces the in-repo `<clone>/release/` folder). The repo still lists `/release/` in `.gitignore` for legacy local paths. Zips are published **only** as GitHub Release assets, never committed.

## Checklist when publishing a new Release

1. `.\packaging\pack-release.ps1 -SelfContained` (or the smaller zip when T033-1 lands).
2. Copy the zip you will ship into `C:\Pier\releases\ped\<version>\` (and optional `backup\` subfolder per fleet release rule).
3. `gh release create vX.Y.Z C:\Pier\releases\ped\<version>\PEDToolbox-...zip` (or from `artifacts\` before copy) — **only** that zip (and later a setup if we add one). Never commit the zip to `v3`.
4. Release notes: first link is the **download** URL above, plus one sentence: source is the `v3` branch, not this zip.
5. Point README “Download” at `/releases/download/...`, not only at `/releases/tag/...`.
