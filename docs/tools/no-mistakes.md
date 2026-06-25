# no-mistakes — validation pipeline → clean PR

**What it is:** A local git proxy / pipeline that takes an agent's first-pass code all
the way to a clean, merged PR — *without you reviewing every diff*. Free & open source.
This is how Kun scales code volume without becoming the bottleneck: act like an
engineering director (set process + hold the bar on risk), not a diff-reviewer.

## What it does (when you push to it)

1. Creates a branch + commit if needed.
2. Works in an **isolated worktree** (your repo is untouched during validation).
3. Infers your **real intent** from the agent session.
4. **Rebases** onto latest `origin/main`, resolving conflicts up front.
5. **Adversarial review** in a fresh context window — auto-fixes obvious issues,
   escalates ambiguous/product calls to you.
6. **End-to-end tests** the change against the intent and **records evidence**
   (screenshot / video / log) attached to the PR.
7. **Docs pass** + **lint**, then pushes and **opens a PR**.
8. **Babysits the PR** (CI failures, new merge conflicts) until it merges.

The PR shows: original intent, what changed, how it was tested (with evidence), what
the pipeline fixed, and a **risk assessment** — so you only deep-review risky changes.

## Install

```bash
./setup.sh no-mistakes
```

- Reviewed installer: `kunchenguid/no-mistakes/main/docs/install.sh` — downloads the
  release binary to `~/.no-mistakes/bin`, symlinks into `~/.local/bin` (our PATH, no
  sudo), starts a local daemon.
- Also tries to add the `/no-mistakes` **skill** (it's PromptScript, so install it
  **per-project** where you use it: `skills add kunchenguid/axi --skill no-mistakes`).

## Daily use

```bash
cd <your repo>
no-mistakes init            # one-time per repo
# then, instead of pushing to origin:
git push no-mistakes
# or, inside an agent:
/no-mistakes                # same pipeline, triggered as a skill
```

> Don't stare at the pipeline — go start other tasks. Come back when it says all checks
> passed, then apply judgment on the PR (deep-review only the risky ones).

## Gotchas

- It runs a **background daemon** (`no-mistakes daemon restart`); restarted on install.
- The **skill is per-project** (PromptScript) — the global install line for it failing
  is expected. The **binary** is global.
- Update: re-run the install script (our wrapper skips if already present).
