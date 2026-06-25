# Agent harnesses (your crew)

**What it is:** The CLI agents you actually talk to. Kun's #1 principle: stay
**agent-agnostic** — the landscape moves fast, so the whole workflow is built so the
*model/harness is swappable*. Everything else in this repo works regardless of which
one you use.

## The four he uses

| Harness | Command | Notes | Install |
|---------|---------|-------|---------|
| **Claude Code** | `claude` | Best out-of-box defaults, rich features; the practical choice on an Anthropic subscription. Slightly buggy, less customizable. | `brew install claude` (or official installer) |
| **Codex CLI** | `codex` | Rust, feels smoother; open source (it can read its own source to debug). Fewer bells & whistles. | `brew install codex` |
| **opencode** | `opencode` | Smooth TUI, model-agnostic, good out-of-box set. Grab-and-go. | `brew install opencode` |
| **Pi** | `pi` | Minimal & highly extensible; for tinkerers who want zero bloat. Needs node ≥22. | `./setup.sh pi` ([pi.md](pi.md)) |

> Pick whichever you like — every technique in this setup is agent-agnostic by design.

## How they share config

Because of the **memory symlink trick** ([memory.md](memory.md)), all of them read the
same global and project memory:
- Claude Code → `CLAUDE.md`
- Codex / opencode / Pi → `AGENTS.md`
- both symlinked to one source of truth in this repo.

Skills installed via the [skills CLI](skills.md) also fan out to all detected agents
at once (it reported "Claude Code, Cline, Codex, Continue, Cursor +3 more").

## Installing the others

```bash
./setup.sh pi      # installs Pi under fnm/node-22 (see docs/tools/pi.md)
# Codex / opencode were already present here via Homebrew/npm.
```

## Gotcha

- **Don't hard-couple your workflow to one harness.** Keep prompts, memory, and skills
  portable; treat the agent as interchangeable. That's the whole point.
