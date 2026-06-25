# Overview — the captain's workflow

This setup replicates Kun's agent-engineering workflow. The metaphor: you're a
**captain** sailing a ship with a **crew of AI agents**. Your job shifts from writing
code to directing a crew — and eventually to deciding *where to sail*.

```
┌──────────────────────────────────────────────────────────────┐
│ 1. THE SHIP                                                    │
│    WezTerm (terminal) ─ tmux (panes/windows/persistence)       │
│      └─ Neovim (editor)   └─ agents in adjacent panes          │
│                                                                │
│ 2. THE CREW (onboarding)                                       │
│    Agents: Claude Code / Codex / opencode / Pi  (swappable)    │
│    Memory: global (~/.claude/CLAUDE.md ↔ AGENTS.md) + project  │
│    Skills: skill-creator + progressive disclosure              │
│                                                                │
│ 3. A SINGLE CREWMATE                                           │
│    Voice (OpenSuperWhisper/VoiceInk) → plan (lavish) → build → │
│    validate (no-mistakes → PR).  Tools matter: AXI ergonomics. │
│                                                                │
│ 4. MANY CREWMATES                                              │
│    gnhf (long/overnight loops) + treehouse (worktree pool)     │
│    = parallel agents that never collide.                       │
│                                                                │
│ 5. THE FIRST MATE                                              │
│    firstmate: talk to ONE agent that runs the whole crew.      │
│                                                                │
│ 6. CAPTAIN'S MINDSET                                           │
│    Bottleneck becomes *what* to build: users, market, vision.  │
└──────────────────────────────────────────────────────────────┘
```

## The core ideas (why, not just what)

- **Terminal-centric** so your hands never leave the keyboard, and the *same* workflow
  works everywhere — even reattaching to a tmux session from your phone.
- **Agent-agnostic.** Models/harnesses change monthly; keep memory, skills, and prompts
  portable so the agent is interchangeable.
- **Memory > fancy systems.** A markdown file that you improve by correcting mistakes
  beats any vector DB. Keep global memory tiny; push conditional knowledge into skills.
- **Don't review every diff.** That makes *you* the bottleneck. Act like an engineering
  director: set process (no-mistakes), hold the bar on risk, deep-review only risky PRs.
- **Tool ergonomics are real performance.** A GitHub MCP server costs ~3× tokens vs the
  CLI; AXI-designed tools win on cost *and* success rate.
- **Scale via parallelism + orchestration.** Free up the middle of every task (gnhf,
  treehouse) and let a first mate juggle the crew.

## How to use this repo

- New machine? → [`../README.md`](../README.md) → `./setup.sh`.
- Setting up one tool? → its page in [`tools/`](tools/).
- Hit a wall? → [`troubleshooting.md`](troubleshooting.md).
- Learned something? → add it to [`tips-and-tricks.md`](tips-and-tricks.md).

## Per-tool doc template

Each `tools/<tool>.md` follows: **What it is → Why → Install → Daily use → Gotchas.**
