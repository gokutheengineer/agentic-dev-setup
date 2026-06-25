# OPINIONS.md

**What it is:** A living map of durable software/product/engineering opinions, so agents
act with a consistent *taste*. Inspired by Kun's
[OPINIONS.md post](https://blog.kunchenguid.com/p/everyone-should-have-an-opinionsmd).

## The idea

Agents make better recommendations when they know your stances — how you weigh
tradeoffs, what you're skeptical of, what "good" looks like. Capturing those durable
beliefs in one file (and feeding it to your agents) makes their judgment calls align
with yours instead of defaulting to generic averages.

This repo seeds the file with a coherent, opinionated baseline (adapted from Kun's
publicly stated views) that you then **edit directly** to make your own. A
`## My divergences` section at the bottom holds explicit overrides and takes precedence
over everything above it.

## How it's wired

- **Always-on summary:** a short "core stances" block in
  [`config/memory/global.md`](../../config/memory/global.md) → loaded into every agent
  session (cheap).
- **Full skill (progressive disclosure):**
  [`config/skills/opinions/SKILL.md`](../../config/skills/opinions/SKILL.md) → loads
  only when the agent hits a judgment/architecture/tooling/product call. Symlinked
  **live** into `~/.claude/skills/opinions` and `~/.agents/skills/opinions`.

```bash
./setup.sh opinions      # links the skill (live symlink) into agent skill dirs
```

This honors both how the file is *deployed* (in agent memory) and the
progressive-disclosure principle (keep global memory tiny, put depth in skills).

## Maintaining it

It's a **hand-maintained markdown file** — edit `config/skills/opinions/SKILL.md`
directly whenever your views sharpen. Because the skill is a **live symlink**, every
agent (Claude / Codex / Cline / Cursor / opencode) sees edits immediately, no reinstall.

To record a disagreement, add it under `## My divergences` — it overrides the matching
stance above.

## Gotchas

- **Live symlink:** editing the repo file updates every agent instantly.
- **Keep the always-on summary short**; the depth lives in the skill (token discipline).
- Treat it as a *map of beliefs*, not a changelog — reorganize as it grows rather than
  appending endlessly.
