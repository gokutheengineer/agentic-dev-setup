# lavish — interactive planning artifacts

**What it is:** "Richer than a rich editor." Lavish turns an agent's plan/comparison/
diff/report into a **reviewable HTML artifact** rendered in your browser (using the
*current project's* design system), where you **annotate specific parts** and click
decision buttons. Feedback goes straight back to the agent — no copy-pasting walls of
text in the terminal. Kun relies on it for planning any complex work.

## Why it beats a "wall of text" plan

- A text plan is hard to scan and you can't easily point at "this part is wrong."
- Lavish shows options visually, consistent with how the app actually looks, and lets
  you annotate exact elements + decide via buttons. Much faster, far less context-switch.

## Install

```bash
./setup.sh lavish      # installs the lavish skill globally
```

- The **skill** installs globally and the agent auto-triggers it for visual planning
  (you don't have to say "use lavish").
- The **`lavish-axi` CLI** runs on demand via `npx -y lavish-axi` — nothing to install.
- PromptScript executable registration is per-project (the global `Failed to install 1`
  line is expected — see [skills.md](skills.md)).

## Daily use

1. Ask the agent to plan/compare something complex.
2. It generates an HTML artifact and opens it locally.
3. **Annotate** elements, leave comments, click decision options.
4. Submit — feedback returns to the agent; iterate without leaving the browser.
5. When happy, tell the agent to start building.

To force it explicitly: *"use lavish"*. To prevent it: *"don't use lavish"*.

## Gotchas

- It runs **locally only** and reuses the project's design system, so artifacts look
  like your real app.
- Needs a working `npx`/Node and a browser.
