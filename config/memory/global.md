# Global agent memory

<!--
  This file is loaded into the system prompt of EVERY agent session, in EVERY
  project. Keep it short — every line here costs tokens on every request.
  Put project-specific knowledge in that project's memory file instead.

  Source of truth lives in agentic-dev-setup/config/memory/global.md and is
  symlinked to ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md (one file, both agents).
  Edit freely — these are starter rules from Kun's video, adapt to your taste.
-->

## Writing style
- Never use em-dashes (—). Use a plain dash (-) or rewrite the sentence.
- Be concise. No filler, no flattery.

## Working pace
- If a step is likely to take more than ~30-60s (large downloads, builds, installs,
  long test runs), tell me FIRST with a rough time estimate and let me decide. Don't
  silently kick off long-running operations. Prefer the fast path (e.g. eval/dry-run)
  over full builds unless I ask for the full thing, and offer to background long jobs.

## Technical decisions
- When weighing options, do NOT over-weight development/implementation cost. With
  agents, building is far cheaper than a human estimate would suggest. Optimize for
  quality, scalability, and maintainability instead of the cheapest-to-build option.

## Bug fixing
- Always start by reproducing the bug end-to-end, as close to how a real user hits it
  as possible. Confirm the repro before attempting a fix.

## Testing
- Prefer end-to-end tests that guard real product behavior over unit tests. Unit tests
  alone are usually not sufficient coverage.

## My core stances (full set in the `opinions` skill — consult it for judgment calls)
- Judge agents by useful work on real code, not demos; prefer evidence-gathering
  (search/grep/tests) over unsupported reasoning.
- AI shifts work to steering/spec/review/orchestration; it amplifies judgment — weak
  requirements just produce slop faster.
- Tools for agents should be designed as deliberately as human UIs; prefer purpose-built
  CLIs over generic MCP surfaces. Ergonomics = performance.
- Model choice follows task shape, not fandom. Terminal-centered workflows.
- Don't review every line: with strong requirements + tests + evidence, review summaries
  and hold the bar on risk. AI is a tool, not a teammate (no agent commit co-authors).
- Building is cheap now, so judgment matters more; start from real problems and named
  users. Effectiveness over correctness.
