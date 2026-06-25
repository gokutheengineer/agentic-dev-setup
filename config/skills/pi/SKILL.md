---
name: pi
description: Run the Pi coding agent (minimal, self-extensible) on this setup. Use when the user wants to launch Pi or asks how to use it here. Pi runs on node 22 via the `pi` shell wrapper (fnm), while the global node stays 18.
---

# pi — minimal, extensible coding agent

Pi has a tiny core (Read/Write/Edit/Bash) and extends via TypeScript extensions, skills,
and templates.

```bash
pi              # launch Pi (wrapper runs it on node 22 via `fnm exec`)
pi --version
```

## Key facts for this machine

- Pi requires **node ≥ 22**; the global node here is 18. The `pi` function in
  `config/shell/agentic.zsh` wraps `fnm exec --using=22 pi`, so it Just Works without
  changing the default node.
- Don't expect a bare `pi` on PATH outside that wrapper — it's installed under fnm's node 22.
- Upgrade: `fnm exec --using=22 npm install -g @earendil-works/pi-coding-agent`.
- It's also a valid `--agent` target for **gnhf** and a harness for **firstmate**.
