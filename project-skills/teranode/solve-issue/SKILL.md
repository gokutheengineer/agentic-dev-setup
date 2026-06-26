---
name: solve-issue
description: Fix a Teranode GitHub issue that the user PASTES into chat. Use whenever the user sends issue text (a title plus description, often with file:line references and proposed fixes) to implement in Teranode. Work ONLY the pasted issue, in its own isolated worktree.
---

# Teranode: solve a pasted GitHub issue

The user PASTES the full issue (title + body, often numbered items with `file:line` and a
proposed fix). That pasted text is the complete source of truth.

## Hard rules (read first)

- **Never fetch the issue.** No `gh issue view`, no network lookup — issues live on a
  private tracker and won't resolve, and you already have the full text. Use what was pasted.
- **Work ONLY the issue the user sent.** Do not look at, read, or reason about other issues,
  other PRs, or any other worktree. Ignore everything under `.claude/worktrees/` except your
  own. No surveying.
- Do every step **inside your own worktree**.
- Follow `.claude/rules/` (testing, go-conventions, architecture, service-interfaces,
  git-workflow).
- **Test scope here OVERRIDES `AGENTS.md`.** Run ONLY the affected packages' tests (Step 6).
  **Never run lint** (`make lint` / `golangci-lint`) — it takes ages and never finishes here.
  Do NOT run `AGENTS.md`'s full-suite verification either (`go test ./...`, staticcheck,
  govulncheck, gosec). Affected-package tests are the only checks you run.

## Step 1 — Own worktree + branch

Branch name MUST follow `gokhan/<serviceName>-<shortDescriptor>` in camelCase
(e.g. `gokhan/blockVal-fixMmap`). Derive `<serviceName>` from the affected service
(blockvalidation → `blockVal`, subtreevalidation → `subtreeVal`, etc.).

```bash
git fetch upstream
b="gokhan/<serviceName>-<shortDescriptor>"
dir=".claude/worktrees/$(printf '%s' "$b" | sed 's#.*/##')"   # flat dir from branch leaf
git worktree add -b "$b" "$dir" upstream/main
cd "$dir"
```

`.claude/worktrees/` is git-ignored, so concurrent issues never collide and nothing leaks.

## Step 2 — Confirm each item is still valid

For each item in the pasted issue, open the cited `file:line` and confirm the described code
still exists as described. If an item was already changed/fixed, note it briefly and **skip
just that item**. This is a read of the **cited code only** — do not browse other issues/PRs.

## Step 3 — Evaluate the proposed fix

Each item usually proposes a fix. If it's correct and idiomatic for Teranode, implement it.
If it's wrong, incomplete, or not the cleanest approach, implement a **better** fix and state
why in one line.

## Step 4 — Implement + add tests

Implement the valid items. **Add tests whenever possible**, per `.claude/rules/testing.md`:
`require` (testify), sqlitememory store (don't mock blockchain client/store), `in_memory_kafka`
(don't mock kafka), no `t.Parallel()` unless testing concurrency, build tag `testtxmetacache`.

## Step 5 — Self-review (issue vs solution)

Re-read the pasted issue against what you built. If they don't truly match — wrong root cause,
missed case, scope drift — **re-implement** until they align.

## Step 6 — Test the affected packages ONLY

From the changed files' directories, run just those packages:

```bash
SETTINGS_CONTEXT=test go test -race -tags "testtxmetacache" -count=1 ./path/to/affected/package/...
```

Do **not** run the full suite (`make test`/`testall`). Repeat per affected package.
**Do not run lint** — skip it entirely.

## Step 7 — Commit (user's name only, tiny message)

Commit with the repo's configured git identity (the user's name) and **never** add an AI /
Claude co-author trailer. Message: one sentence, **max 6-7 words**, imperative.

```bash
git add -A
git commit -m "remove redundant mutex in blockvalidation"
```

Do not push or open the PR automatically — the user does that.

## Safety (git-workflow.md)

- Never `git reset --hard` (use `git stash`). Never auto-resolve merge/rebase conflicts —
  stop, show the files, ask the user.

## Step 8 — Output the PR (LAST thing in your answer)

End your reply with a ready-to-paste PR, in markdown:

```markdown
## PR title
<concise imperative title>

## PR description
**Closes #<number>.**

### Problem
<what was wrong / which items were confirmed still valid, which were skipped>

### Fix
<what changed and why; note any place you improved on the proposed fix>

### Tests
<tests added + the exact scoped `go test ...` commands run (affected packages only)>
```
