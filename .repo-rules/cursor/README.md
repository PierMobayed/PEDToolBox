# Cursor-only rules

Roles and setup for Cursor chats (local and cloud). Shared merge / models / keys / docs: [../common/](../common/).

| File | What |
|------|------|
| [SETUP.md](./SETUP.md) | User Rule, committed `.repo-rules/`, fleet.mdc, sync/review, chat opener |
| [local-access.md](./local-access.md) | Remote Control vs `laptop` worker, visibility, builds, `/summarize` |
| [roles/product.md](./roles/product.md) | Product |
| [roles/code.md](./roles/code.md) | Code |
| [roles/review.md](./roles/review.md) | Review |
| [roles/release.md](./roles/release.md) | Release |
| [roles/coord.md](./roles/coord.md) | Coord |
| [roles/installbot.md](./roles/installbot.md) | installbot — commit `.repo-rules/` snapshot into the open project |
| [templates/subagent-coordinator.md](./templates/subagent-coordinator.md) | Product/Coord subagent protocol |

**Projects commit a `.repo-rules/` snapshot** (not a second env repo, not gitignored). See [SETUP.md](./SETUP.md).
