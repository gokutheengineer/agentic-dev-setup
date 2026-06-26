# Tips & Tricks

A running log of the non-obvious things we discover during setup — the stuff that
isn't in any single tool's README. Newest at the top.

> Format: `### [tool] short title` → what / why / how.

---

### [voice] Voice input deferred (tried VoiceInk, MacWhisper, OpenWhispr — all removed)
**What:** No dictation app is installed or configured right now.
**Why:** On Intel, VoiceInk didn't work; MacWhisper/OpenWhispr were too heavy/slow/paid.
OpenSuperWhisper (Kun's free pick) is Apple-Silicon-only. Revisit later.
**How:** the `voice` setup step was removed; macOS built-in Dictation is the stopgap.

### [skills] Popular ≠ good; skills run with full agent permissions
**What:** Kun's hard rule: don't install internet skills without rigorous evidence.
**Why:** A skill can run anything on your machine (key/cred exfiltration), and a
177k-star skill he benchmarked used 5% more tokens while making results *worse*.
**How:** Prefer first-party (Anthropic) skills or ones you've read; ignore star counts.

### [skills] "PromptScript does not support global" is expected, not an error
**What:** `skills add <x> -g` prints this for skills with an executable component.
**Why:** Only the markdown/doc part installs globally; PromptScript parts are per-project.
**How:** Treat it as informational. The doc skill (skill-creator, axi guidance) still
installs globally — verify with `skills list -g`. Install PromptScript parts inside the
project that needs them.

### [skills] AXI & lavish install *through* the skills CLI
**What:** The agentic tools aren't standalone apps — they're agent skills.
**Why:** `npx skills add kunchenguid/axi` etc. registers them with Claude Code & co.
**How:** Install skills CLI first; everything else is `skills add <owner>/<repo>`.

### [meta] One shell entrypoint, idempotently sourced from .zshrc
**What:** All aliases/PATH live in `config/shell/agentic.zsh`, linked to
`~/.config/agentic-dev-setup.zsh`; `.zshrc` gets ONE managed `source` line.
**Why:** Re-running setup never duplicates lines in `.zshrc`; one file to edit.
**How:** `ensure_line` greps before appending; `ensure_shell_sourced` ties it together.

### [nvim] Pin nvim-treesitter to `master` (the `main` branch broke the API)
**What:** `require("nvim-treesitter.configs").setup{}` errors on a fresh install.
**Why:** lazy pulls treesitter's default branch, now `main`, which removed `.configs`.
**How:** add `branch = "master"` to the plugin spec. Verified: `module
'nvim-treesitter.configs' not found` → gone after pinning.

### [nvim] rose-pine sets `colors_name = "rose-pine"` regardless of variant
**What:** After `colorscheme rose-pine-moon`, `vim.g.colors_name` reads `rose-pine`.
**Why:** The plugin reports the family, not the variant — not a bug.
**How:** Set the variant in `require("rose-pine").setup{ variant = "moon" }`.

### [nvim] `vim.highlight` → `vim.hl` on 0.12+
**What:** `vim.highlight.on_yank()` is deprecated on Neovim 0.12.
**Why:** Throws a deprecation warning; will eventually break.
**How:** Use `(vim.hl or vim.highlight).on_yank()` to support both old and new nvim.

### [no-mistakes] Pin link dir to ~/.local/bin to skip the sudo prompt
**What:** The official installer symlinks into /usr/local/bin (needs sudo) unless
~/.local/bin is already on PATH.
**Why:** The setup shell may not have ~/.local/bin on PATH yet, triggering sudo.
**How:** Run it as `... | NO_MISTAKES_LINK_DIR="$HOME/.local/bin" sh` — no sudo, and
our agentic.zsh already puts ~/.local/bin on PATH.

### [meta] Review curl|sh installers before piping them
**What:** no-mistakes & treehouse install via `curl … | sh`.
**Why:** Piping a remote script to a shell runs whatever it contains.
**How:** `curl -fsSL <url> -o x.sh` → read it → then run. (Both checked out clean:
standard release-binary download + symlink, no funny business.)

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

### [memory] Version your global memory in the repo, symlink it to agents
**What:** `~/.claude/CLAUDE.md` + `~/.codex/AGENTS.md` are symlinks to
`config/memory/global.md` in this repo.
**Why:** One file for all agents AND it's in git — a new laptop gets your exact
preferences by running `./setup.sh memory`.
**How:** `link` backs up any existing target first; safe to re-run.

### [memory] Keep global memory tiny; it taxes every single request
**What:** Global memory loads into every session in every project.
**Why:** Bloat silently burns tokens on requests that don't need it.
**How:** Keep ~20-30 lines of durable prefs; push conditional how-tos into skills and
project-specific knowledge into the project memory file.

### [pi] Run a node-22 tool without disturbing global node 18 (fnm exec)
**What:** Pi needs node >=22.19.0; the machine's default is 18 (used by ~30 projects).
**Why:** `brew install node` would replace global node and risk breaking those repos.
**How:** `brew install fnm` → `fnm install 22` → install Pi under it → wrap the command:
`pi() { fnm exec --using=22 pi "$@"; }`. `fnm exec` needs no shell integration, so the
launcher is self-contained and the default `node` stays v18.

### [gnhf] node 18 vs the >=20 engine requirement — don't nuke global node
**What:** gnhf declares `engines.node >=20`; this machine is on 18 (used by ~30 other
projects). gnhf still runs on 18 in practice (verified `gnhf --help`).
**Why:** `brew install node` would replace the global node and could break those repos.
**How:** If a node-20 tool misbehaves, install `fnm` and `fnm use 20` per-shell instead
of upgrading the system node. Leave the global node alone.

### [meta] Symlink configs, don't copy them
**What:** `setup.sh` symlinks files from `config/` into `~/.config` etc.
**Why:** Edit once in the repo, it's live everywhere, and `git` tracks every change.
**How:** The `link()` helper in `scripts/lib.sh` backs up any pre-existing file first.
