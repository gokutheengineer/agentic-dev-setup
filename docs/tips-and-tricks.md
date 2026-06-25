# Tips & Tricks

A running log of the non-obvious things we discover during setup — the stuff that
isn't in any single tool's README. Newest at the top.

> Format: `### [tool] short title` → what / why / how.

---

### [meta] Keep node current for npx-based agentic tools
**What:** Some `npx` tools assume a recent Node LTS. The machine started on Node 18.
**Why:** Newer CLIs (skills, etc.) may use modern syntax / fetch APIs.
**How:** `brew install node` gives a current major; verify with `node --version`.

### [meta] Symlink configs, don't copy them
**What:** `setup.sh` symlinks files from `config/` into `~/.config` etc.
**Why:** Edit once in the repo, it's live everywhere, and `git` tracks every change.
**How:** The `link()` helper in `scripts/lib.sh` backs up any pre-existing file first.
