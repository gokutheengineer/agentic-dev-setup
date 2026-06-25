---
name: memory
description: Maintain the user's agent memory files. Use when the user says "remember this", corrects a mistake they want avoided next time, or when durable project conventions/architecture should be recorded so future sessions don't repeat work or errors. Knows the global-vs-project split and the CLAUDE.md<->AGENTS.md symlink so all agents share one file.
---

# memory — record durable knowledge so the crew gets smarter

Two levels:

| Level | File | Scope | Size |
|-------|------|-------|------|
| **Global** | `~/.claude/CLAUDE.md` (↔ `~/.codex/AGENTS.md`) | every project | keep tiny — loads every request |
| **Project** | `<repo>/CLAUDE.md` (↔ `AGENTS.md`) | that repo | can be verbose; the repo's collected learning |

Source of truth for global memory is versioned at
`agentic-dev-setup/config/memory/global.md` and symlinked to the agent paths.

## When the user says "remember this"

1. Decide scope: a **personal preference / durable stance** → global; **project-specific
   fact** (architecture, convention, how to test, a mistake to avoid) → that project's memory.
2. Append a concise, durable line. For project memory, prefer a `Lesson:` entry:
   `<date> — <mistake observed> → <rule to prevent it>`.
3. Don't bloat global memory — it taxes every request. Move conditional how-tos into a
   **skill** instead.

## The symlink trick (one file, all agents)

Claude Code reads `CLAUDE.md`; Codex/opencode/Pi read `AGENTS.md`. Point them at one file:

```bash
cd <repo> && ln -s CLAUDE.md AGENTS.md   # then `git add` both
```

Global is already wired by `setup.sh memory`. Don't duplicate content across the two
names — symlink them.
