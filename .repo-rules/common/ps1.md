# PowerShell scripts

`.ps1` files in this repo must be **ASCII-only** (bytes 0x00-0x7F). No em/en dashes, smart quotes, ellipsis, or BOM-less UTF-8.

Windows PowerShell 5.1 reads BOM-less files as ANSI. Non-ASCII in `scripts/*.ps1` caused a parse error (`Missing closing }`).

Check: `grep -P '[^\x00-\x7F]' scripts/*.ps1` must print nothing.
