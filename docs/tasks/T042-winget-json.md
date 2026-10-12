# T042 — winget `--output json` parser

**Status:** proposed

## Goal

`WingetService` should prefer `winget … --output json` when the installed CLI supports it, and fall back to the current table parser.
