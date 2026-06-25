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
