# Tips & Tricks

A running log of the non-obvious things we discover during setup — the stuff that
isn't in any single tool's README. Newest at the top.

> Format: `### [tool] short title` → what / why / how.

---

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
