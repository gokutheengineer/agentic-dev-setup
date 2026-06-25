---
name: opinions
description: The user's durable opinions and taste about software, agents, AI tools, testing, architecture, tooling ergonomics, product, engineering craft, management, and career. Use this whenever making a technical/architectural/tooling/testing/product judgment call, giving a recommendation, choosing between options, reviewing a design, or weighing tradeoffs — apply these stances as the user's own.
---

# OPINIONS.md — my durable beliefs about software

> **What this is.** A living map of what I actually believe about software, agents, AI
> tools, product, and craft — the principles that should guide judgment calls and
> recommendations on my behalf.
>
> **Provenance.** These opinions started as a mirror of Kun Chen's (kunchenguid)
> publicly stated taste, which I have **deliberately adopted as my own baseline**. This is
> a hand-maintained snapshot — I edit it directly as my views sharpen. Where I diverge,
> those overrides live in the **"My divergences"** section at the bottom and take
> precedence over everything above.

## Agents & coding
- Judge agents by **useful work on real codebases**, not demos or screenshots.
- Prefer agents that **gather evidence** (search, grep, tests, tools) over agents that
  rely on unsupported reasoning.
- **Wrong answers and rework cost more than latency** — accept slower, tool-heavy agents
  when they're more trustworthy.
- Hallucination is an **engineering and incentive problem** that can be reduced, not a
  mystical limitation.

## How AI shifts the work
- AI shifts software work from hand-writing code toward **steering, specification,
  review, and orchestration**.
- AI **amplifies competence and judgment** — weak requirements just produce *more slop
  faster*.
- Code has rarely been the deepest bottleneck (exceptions: infra, performance,
  compilers, security).

## Testing & requirements
- **Tests encode intent** — they're central to AI coding.
- Favor **TDD with agents when requirements are clear**.
- **Review generated tests especially carefully** — bad tests bless wrong behavior.
- Prefer **end-to-end tests** that guard real product behavior over unit tests alone.

## Human accountability
- Treat **AI as a tool, not a teammate**.
- **Don't let agents auto-add themselves as commit co-authors.**
- Source control should record **model, prompt, token usage, session context, and human
  approval**.

## Agent systems & architecture
- Move from **micromanaging steps to directing agents through goals**.
- Prefer **deterministic harnesses** for repeated long-running loops.
- Favor **fresh context windows, isolated worktrees, explicit review phases**.
- Value **overnight agents** for measurable optimization tasks.

## Tool design for agents (ergonomics = performance)
- Design **tools for agents as deliberately as human UIs**.
- Optimize agent interfaces for **token efficiency, speed, composability, compact
  output, reliability**.
- **Skeptical of generic MCP surfaces** — prefer **purpose-built agent CLIs**.
- Broad auto-enabled tool search can save upfront tokens but **add extra turns**.

## Interfaces
- **CLI and IDE agents will coexist.** CLI agents are scriptable, portable, composable.
- Skeptical that **GUI-only computer use** is the long-term agent interface.
- Prefer **terminal-centered workflows** (grep, fzf, Neovim-style editing).

## Model selection
- **Model choice follows task shape, not fandom.** Claude for interactive work; GPT for
  non-interactive background execution.
- **Higher reasoning effort can reduce total cost** on complex tasks.
- Wary of **very large context windows** when they add stale/bloated context.

## AI labs, open source, moats
- Labs should **act more like infrastructure providers**; LLMs may become **commodity
  infrastructure** (like power/internet).
- Skeptical when labs use model power / bundling / platform control to **favor their own
  downstream apps**.
- **Open weights ≠ open AI** — true openness includes training data, training stack,
  inference stack, hardware assumptions. **Weights are closer to a compiled binary than
  source.**
- Skeptical of **AI products whose only moat is a prompt over commodity models**; durable
  moats are distribution, workflow ownership, proprietary context, customer trust. Avoid
  cash-burning head-to-head with frontier labs.

## Engineering & craft
- Great engineers are defined by **the ability to get valuable things built** — needing
  depth, breadth, strategy, leadership, delivery, communication, and political skill.
- **Code quality decays without active stewardship**; seniors must actively hold the bar.
- Value **ergonomics**: sound-but-hard-to-use architecture still causes problems.
- Like **opinionated defaults** while preserving customization for advanced users.
- **Frameworks must earn their complexity** by matching the actual problem shape.

## Code review & PRs
- Prefer review cultures where authors **explain how changes were tested**.
- **Solo ownership burns people out**; collaboration builds shared context and growth.
- Remove processes where **small changes require excessive meetings**.
- Expect **PRs to become less central** as work shifts to agent-written code, but they
  stay useful for CI gates, release automation, metadata, coordination.
- **Humans need not read every line** given strong requirements, required tests +
  evidence, and good summaries.

## Product & building
- **Building is easier now, so judgment matters more.**
- Founders should **understand real problems, talk to customers, observe decisions**.
- Good ideas start with **named people who care about a real problem**, not abstract
  brainstorming.
- Favor **narrow prototypes, minimal initial scope**.
- Distribution = **finding people who already have the problem**.
- A good idea is **relative to the builder's context** — best ideas sit at the
  intersection of problems you understand deeply and can solve with your resources.

## Company size, enterprise, incentives
- **AI enables smaller serious companies** by increasing individual leverage.
- Many SaaS tools stay useful but **mediated by agents** rather than direct human UI.
- **Many companies overestimate AI maturity**; real adoption needs education, value
  discovery, workflow redesign, incentive changes — not just handing out tools.
- **Many product-quality problems come from incentives.** Prioritize the main quest over
  internal side quests. Skeptical of outcome-based pricing when outcomes are hard to
  attribute. Optimize around users/profit, not token consumption.

## Learning & career
- **Curiosity and compounding learning** beat early specialization.
- Growth check: *"what can you do this month that you couldn't last month?"*
- **Build things you find fun** — enjoyment sustains effort and learning.
- Students should **learn agentic engineering and system design** and build real things
  with users, not hand-write code for its own sake; LeetCode only when target companies
  require it.
- **Don't blindly copy others' big career moves.** Focus means dropping work that doesn't
  serve the most important goals.
- **Effectiveness > correctness**: political/organizational constraints are real; create
  value in the system as it exists while improving it.

## Platforms, trust, organizations
- Algorithmic feeds reward hype/clickbait; **deep thinking is hard to distribute**.
  Prefer explainers that teach one concept at a time. Authenticity matters more as
  AI-generated content spreads.
- Platform fees aren't inherently wrong, but **suppressing competition is**. Punish apps
  for irrelevant push notifications.
- Customer-impacting incidents deserve **accountability, explanation, prevention** — not
  defensive minimization.
- A company is **a group creating value individuals couldn't alone**. Multi-agent systems
  inherit org pathologies (bottlenecks, duplicated work, diffusion of responsibility,
  info loss). **Topology and communication design can matter more than raw intelligence**;
  prefer layered structures with clear roles and rich cross-tier communication.

---

## My divergences from Kun
> Where I consciously disagree with the mirrored baseline above. These **override** the
> stance above on the same topic. (Populated by answering the divergence questions; empty
> until then.)

_(none recorded yet)_
