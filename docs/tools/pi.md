# Pi — minimal, self-extensible coding agent

**What it is:** A coding-agent harness by Mario Zechner (earendil-works) with a tiny
**4-tool core** (Read / Write / Edit / Bash) that you extend at runtime via TypeScript
extensions, skills, prompt templates, and themes. Integrates 20+ model providers. The
"minimal and highly extensible, no bloat" option Kun mentions.

## Install

```bash
./setup.sh pi
```

⚠️ **Pi requires node ≥ 22.19.0** — your default node is 18 (and ~30 other projects rely
on it). So the installer:
1. installs **`fnm`** (a per-shell node version manager) — does **not** change your
   global node;
2. installs **node 22** under fnm;
3. installs Pi globally *under node 22* (`npm i -g --ignore-scripts @earendil-works/pi-coding-agent`);
4. adds a **`pi` shell launcher** that runs it on node 22 via `fnm exec`.

Your global `node --version` stays `v18.17.1`.

## Daily use

```bash
pi                 # launches Pi (wrapped to node 22 automatically)
pi --version
```

It's also a valid `--agent` target for [gnhf](gnhf.md) and a harness option for
[firstmate](firstmate.md) (`FIRSTMATE_AGENT=pi firstmate`) — both resolve the `pi`
launcher.

## Gotchas

- **Don't expect `pi` to work without the shell launcher.** It lives under fnm's node 22,
  not your default PATH. The launcher (`config/shell/agentic.zsh`) bridges that with
  `fnm exec --using=22 pi`.
- We used the **`npm --ignore-scripts`** method rather than the interactive
  `curl pi.dev/install.sh | sh` (1200-line interactive installer) for a clean,
  scriptable install.
- To upgrade Pi: `fnm exec --using=22 npm install -g @earendil-works/pi-coding-agent`.
