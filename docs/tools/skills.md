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
- **Global** (`-g`): available to every project on this machine. Good for always-on
  doc skills like `skill-creator` and `axi` (the guidance part).

### skill-creator (installed globally by `./setup.sh skills`)

Anthropic's skill that teaches the agent to *create, edit, and eval* skills. With it
installed, you can ask any agent "extract these instructions into a project skill" and
it knows how. This is how you move conditional instructions out of memory files (see
[memory.md](memory.md)) to save tokens via **progressive disclosure** — only a skill's
one-line description loads up front; the body loads only when the skill is actually used.

```bash
skills add anthropics/skills --skill skill-creator -g -y   # done by setup.sh
skills list -g                                             # verify
```

### Plain doc skills vs PromptScript skills

- **Doc skills** (markdown only, e.g. `skill-creator`, `axi` guidance) → install
  **globally** fine.
- **PromptScript skills** (have an executable component, e.g. AXI's tooling, lavish)
  → **per-project only**. Installing them with `-g` prints
  `PromptScript does not support global skill installation` for that part — expected,
  not a failure of the doc skill.

## This repo's own skills (`config/skills/`)

Beyond the upstream skills installed via the CLI (axi, lavish, no-mistakes, skill-creator),
this repo **ships its own** `SKILL.md` per tool that lacks an upstream one — `nix-setup`,
`tmux`, `treehouse`, `gnhf`, `firstmate`, `memory`, `skills-cli`, `pi`, `wezterm`, `nvim`,
and `opinions`. They're version-controlled here and installed as **live symlinks** into
the agent skill dirs by:

```bash
./setup.sh local-skills
```

Edit any `config/skills/<name>/SKILL.md` and every agent sees it immediately (no reinstall).
To author a new one, use the **skill-creator** skill or `skills init`.

## ⚠️ Security: don't install random skills (Kun's warning)

Skills run **with full agent permissions** — they can instruct your agent to run
anything on your machine (exfiltrate API keys, bank creds, etc.). And popularity ≠
quality: Kun benchmarked a 177k-star skill repo and found it used **5% more tokens
while making results worse**.

Rule of thumb:
- **Never** install a skill that *claims* to magically improve your agent without
  published, rigorous evidence.
- GitHub stars measure popularity, not whether it helps.
- Prefer first-party (Anthropic) or skills you've read and understand.

## Gotchas

- **Symlink vs copy:** default symlinks into agent dirs; use `--copy` if a tool
  doesn't follow symlinks.
- **`npx` re-downloads** on a cold cache the first time each session — that's normal.
- Needs a working Node/npm. We rely on Homebrew's `node`.
