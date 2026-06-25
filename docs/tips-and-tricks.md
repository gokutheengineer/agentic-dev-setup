# Tips & Tricks

A running log of the non-obvious things we discover during setup — the stuff that
isn't in any single tool's README. Newest at the top.

> Format: `### [tool] short title` → what / why / how.

---

### [opensuperwhisper] Arch-guard installers instead of failing
**What:** `scripts/opensuperwhisper.sh` checks `uname -m` and only installs on arm64.
**Why:** OpenSuperWhisper is Apple-Silicon-only; on this Intel Mac a hard install would
error. The guard makes `./setup.sh` succeed everywhere and self-heal on a new laptop.
**How:** `[ "$(uname -m)" != "arm64" ] && return 0` early-out with a clear message.

### [skills] AXI & lavish install *through* the skills CLI
**What:** The agentic tools aren't standalone apps — they're agent skills.
**Why:** `npx skills add kunchenguid/axi` etc. registers them with Claude Code & co.
**How:** Install skills CLI first; everything else is `skills add <owner>/<repo>`.

### [meta] One shell entrypoint, idempotently sourced from .zshrc
**What:** All aliases/PATH live in `config/shell/agentic.zsh`, linked to
`~/.config/agentic-dev-setup.zsh`; `.zshrc` gets ONE managed `source` line.
**Why:** Re-running setup never duplicates lines in `.zshrc`; one file to edit.
**How:** `ensure_line` greps before appending; `ensure_shell_sourced` ties it together.

### [nvim] Keep the base config plugin-free to avoid distro conflicts
**What:** Our `init.lua` has zero plugins/plugin-manager.
**Why:** Dropping in LazyVim/kickstart later won't fight a half-configured base.
**How:** Good defaults only; bootstrap `lazy.nvim` *when* you actually want plugins.

### [nvim] `vim.highlight` → `vim.hl` on 0.12+
**What:** `vim.highlight.on_yank()` is deprecated on Neovim 0.12.
**Why:** Throws a deprecation warning; will eventually break.
**How:** Use `(vim.hl or vim.highlight).on_yank()` to support both old and new nvim.

### [tmux] Run agents inside tmux so they survive disconnects
**What:** Start long agent runs in a tmux session, then `prefix d` to detach.
**Why:** Closing the terminal (or losing SSH) won't kill the agent — reattach later
with `tmux attach`. This is the single biggest reason tmux is in this stack.
**How:** `tmux new -s work` → run agent → `Ctrl-a d` → later `tmux attach -t work`.

### [tmux] Validate a tmux.conf without breaking your session
**What:** Test a config edit safely.
**Why:** A bad line can wedge your prefix key.
**How:** `tmux -f path/to/tmux.conf new-session -d -s _t && tmux kill-session -t _t`
— if it errors, the config is bad; your real session is untouched.

### [wezterm] JetBrains Mono is bundled — no font install needed
**What:** The config sets `JetBrains Mono` as the font.
**Why:** You'd expect to `brew install` a nerd font first.
**How:** WezTerm ships JetBrains Mono internally, so it Just Works. `Menlo` is the
system fallback in the config if you ever change machines.

### [meta] Keep node current for npx-based agentic tools
**What:** Some `npx` tools assume a recent Node LTS. The machine started on Node 18.
**Why:** Newer CLIs (skills, etc.) may use modern syntax / fetch APIs.
**How:** `brew install node` gives a current major; verify with `node --version`.

### [meta] Symlink configs, don't copy them
**What:** `setup.sh` symlinks files from `config/` into `~/.config` etc.
**Why:** Edit once in the repo, it's live everywhere, and `git` tracks every change.
**How:** The `link()` helper in `scripts/lib.sh` backs up any pre-existing file first.
