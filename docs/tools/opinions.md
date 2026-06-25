# OPINIONS.md — mirroring Kun

**What it is:** A living map of my durable software/product/engineering opinions, so
agents act with *my taste*. Inspired by Kun's
[OPINIONS.md post](https://blog.kunchenguid.com/p/everyone-should-have-an-opinionsmd) —
with one deliberate inversion.

## The twist: mirror Kun, don't mirror myself

Kun's cron distills *his own* posts into *his* opinions. Mine does the opposite:
**I adopt Kun's opinions as my baseline**, and the sync pulls updates from **his**
writing — so as his views evolve, mine track them. I only diverge where I consciously
decide to (recorded in the "My divergences" section, which overrides everything else).

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

This honors both how Kun *deploys* it (in agent memory) and what he *believes*
(progressive disclosure / keep global memory tiny).

## Updating from Kun (manual)

```bash
./scripts/sync-opinions.sh
```

Calls Claude Code headless to fetch Kun's latest Substack/writing, extract durable
opinions (excluding jokes/code/recipes), reorganize OPINIONS.md in first person, and
print a **DRIFT REPORT** when a new stance contradicts an old one. It leaves the change
**uncommitted** so you review the diff first. The **"My divergences"** section is never
touched by the sync.

## My divergences

Where I disagree with Kun, it's recorded under `## My divergences from Kun` at the
bottom of the skill and **overrides** the mirrored stance. Populate it by answering the
divergence questions (Claude can re-ask anytime: *"quiz me on where I differ from Kun"*).

## Gotchas

- **It's a live symlink** — `sync-opinions.sh` edits the repo file and every agent sees
  it immediately; no re-install needed.
- Keep the always-on summary short; the depth lives in the skill (token discipline).
- Re-running the sync **reorganizes** rather than appends — it won't grow unbounded.
