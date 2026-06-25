# skills CLI (vercel-labs/skills)

**What it is:** The CLI for the open **agent-skills** ecosystem. Skills are reusable
instruction sets (`SKILL.md`) that extend a coding agent's abilities. The `skills` CLI
adds/removes/updates them across 70+ agents (Claude Code, Cursor, OpenCode, …).

This is the **gateway** for the rest of the toolchain — AXI and lavish are installed
*through* it.

## Install

Nothing to globally install — it runs via `npx`. We add a convenience alias:

```bash
./setup.sh skills
# wires up: alias skills='npx -y skills@latest'  (via ~/.config/agentic-dev-setup.zsh)
```

> Open a new terminal (or `source ~/.zshrc`) so the `skills` alias is live.

## Daily use

| Command | What it does |
|---------|--------------|
| `skills add <owner>/<repo>` | Install a skill package to your agents |
| `skills add <repo> -g` | Install **globally** (user-level, all projects) |
| `skills add <repo> --skill <name>` | Install just one skill from a repo |
| `skills add <repo> -l` | List available skills in a repo (no install) |
| `skills list` / `skills ls` | Show installed skills (add `-g` for global) |
| `skills find <query>` | Search the ecosystem |
| `skills use <repo>@<skill>` | Get a one-off prompt without installing |
| `skills update` | Update installed skills |
| `skills remove <skill>` | Uninstall |
| `skills init <name>` | Scaffold a new `SKILL.md` |

### Scope: project vs global

- **Project** (default in a repo): skill lives with that project.
- **Global** (`-g`): available to every project on this machine. Good for the
  always-on tools like AXI.

## Gotchas

- **Symlink vs copy:** default symlinks into agent dirs; use `--copy` if a tool
  doesn't follow symlinks.
- **`npx` re-downloads** on a cold cache the first time each session — that's normal.
- Needs a working Node/npm. We rely on Homebrew's `node`.
