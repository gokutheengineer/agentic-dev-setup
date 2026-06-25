# Memory files

**What it is:** Markdown files that onboard your agents. They're loaded into the
agent's context so it knows your preferences (global) and how a given project works
(project-level). This is how you "ramp up your crew" in the video — no fancy memory
system needed, just markdown that improves over time.

## Two levels

| Level | File | Loaded | Size |
|-------|------|--------|------|
| **Global** | `~/.claude/CLAUDE.md` (+ `AGENTS.md`) | *every* session, *every* project | keep tiny — it costs tokens on every request |
| **Project** | `<repo>/CLAUDE.md` (+ `AGENTS.md`) | sessions in that repo | can be verbose; it's the repo's collected learning |

## The symlink trick (one file, all agents)

Claude Code reads `CLAUDE.md`; Codex / opencode / most others read `AGENTS.md`.
Instead of maintaining two copies, point them at one file.

Our setup goes one step further: the **source of truth lives in this repo**
(`config/memory/global.md`) and the agent paths symlink to it — so your global memory
is version-controlled and travels to a new laptop.

```bash
./setup.sh memory
# links ~/.claude/CLAUDE.md, ~/.codex/AGENTS.md, ~/.config/opencode/AGENTS.md
#   -> config/memory/global.md
```

Edit one file (`config/memory/global.md`), every agent sees the change.

### Per-project memory

```bash
cp <repo>/path/to/project-template.md  <yourproject>/CLAUDE.md
cd <yourproject> && ln -s CLAUDE.md AGENTS.md   # both agents share it
git add CLAUDE.md AGENTS.md
```

Template: [`config/memory/project-template.md`](../../config/memory/project-template.md).

## How to build good memory

- **Global** (`config/memory/global.md`): only durable personal preferences. Starter
  rules from the video: no em-dashes; don't over-weight dev cost; reproduce bugs
  end-to-end first; prefer e2e tests over unit tests.
- **Project**: don't write it all by hand. When an agent gets something wrong, correct
  it and say *"remember this in the project memory file so you don't repeat it."* Over
  many sessions the crew gets smarter.
- **Trim with skills:** move conditionally-needed instructions (e.g. "how to run e2e
  tests") out of memory into a [skill](skills.md) so they only load when relevant.

## Gotchas

- **Global memory bloat = silent token tax.** Kun keeps his ~27 lines. If it grows,
  move things into skills or project memory.
- **The symlink is tracked by git**, but its *target* (this repo path) must exist on
  the machine. Running `./setup.sh memory` recreates the links on a new laptop.
