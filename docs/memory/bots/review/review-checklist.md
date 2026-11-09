# Ped Review — checklist

Run this on every PR, at the exact head SHA.

## 1. Identity
- Head SHA, base `v3` and base SHA (is the base still v3's head?).
- Commit list and parents. Prefer one clean commit. Intermediate commits reach v3 via the merge commit, so check them too.
- Draft or open; mergeable_state.

## 2. Scope
- Real file list and count. Compare with what the PR body claims.
- Docs-only or code? For code: src/, CI, packaging/, manifests.
- Renames: are they real renames, and is any content lost?
- No overwrite of the `Tool`/v1 branch or trees unless Pier assigned it.

## 3. Risk areas
- Elevation: `asInvoker` vs `requireAdministrator` in the app manifest; UAC prompts.
- Store/MSIX: AppxManifest identity/publisher (CN), capabilities.
- winget manifests in packaging/winget: URL and SHA256 match the release. Opening a microsoft/winget-pkgs PR needs Pier's OK.
- Release: no committed zip and no `release/` content; local path rule.

## 4. Public-repo hygiene
- No secrets, keys, tokens, IPs, operator paths or security details.
- No `.repo-rules/` content committed. No SECRETS-MAP file or gitignore line.
- No private repo URLs (repo-rules, appkeys, grokbotsrules) in the patch, commit messages, PR title or PR body. Plain-text names are OK.

## 5. Docs rules
- Every relative link resolves at head (all docs, not only changed files).
- Status keys: proposed, next, doing, merged, shipped in X, deferred, superseded → ID, done, waiting (external: X).
- Done or merged rows go to HISTORY. No merge SHAs in STATUS; STATUS has at most 40 lines.
- Statuses agree across TASKS, BRIEFS and plans.
- PRIVACY/store claims match the code.

## 6. CI
- build, Pull Request Router and Security Reviewer must all be green on the head SHA.

## 7. Verdict
- COMMENT review with commit_id = head: `Ped Review verdict: APPROVE|REQUEST CHANGES @ <full sha>`. Split findings into blocking and nits.
- Send the verdict with the full SHA to Ped Product.

## Recurring mistakes seen
- Folder moves leave broken relative links in untouched files.
- Statuses set ahead of the event (`merged` before the merge).
- A private link in the PR body or an intermediate commit.
- The PR body overstates the scope or the fixes ("links fixed", "rg finds nothing").
