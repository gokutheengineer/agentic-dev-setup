---
name: gnhf
description: Run an autonomous, long-running agent loop with gnhf ("good night, have fun") toward a verifiable objective until a stop condition. Use when the user wants an agent to keep iterating unattended (e.g. overnight) on measurable goals — test coverage, performance, bug-hunting, hypothesis sweeps — with token or iteration caps.
---

# gnhf — long-running autonomous loops

Keeps an agent iterating toward an objective, committing wins and rolling back failures,
until a stop condition. Best for **verifiable** goals or ones you trust the agent's
judgment on — not vague open-ended design.

```bash
gnhf "Reduce p95 page load; measure before/after each change." --max-iterations 40
gnhf "<objective>" --max-tokens 2000000
gnhf "<objective>" --stop-when "no more issues found"
gnhf "<objective>" --worktree            # isolate so other work can run in parallel
gnhf "<objective>" --agent codex         # claude | codex | opencode | copilot | pi | ...
gnhf "<objective>" --prevent-sleep on    # keep the Mac awake overnight
```

## Guidance

- Give it a **clear, checkable** objective and a **cap** (iterations/tokens/stop-when).
- Use `--worktree` (or run under **treehouse**) so a long loop doesn't block other work.
- It shows iterations (moons), token usage, and commit count; review the branch's commits
  when it finishes and keep what you want.
- Finer control than `/goal` in Claude Code/Codex (explicit caps avoid blowing a quota).
