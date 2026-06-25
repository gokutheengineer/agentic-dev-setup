# AXI — Agent eXperience Interface

**What it is:** A set of design standards (10 principles) Kun authored for building CLI
tools that **agents** use efficiently — treating the agent as a first-class user.
Catalog & docs: [axi.md](https://axi.md).

## Why it matters (agent ergonomics)

The tools you hand your agent hugely affect its performance:
- The **GitHub MCP server** costs ~**3× the tokens** and **>2× the latency** of the
  GitHub **CLI** for the same tasks.
- AXI-designed tools had the **lowest cost and highest success rate** in Kun's benchmark.
- Token-efficient output formats (TOON) save ~**40%** tokens vs JSON.

The takeaway: **research the efficiency of the tools you give agents.** Prefer CLIs and
AXI-style tools over heavy MCP servers when you can.

## Install

```bash
./setup.sh axi      # installs the AXI guidance skill globally
```

- The **guidance skill** (how to build/review agent-ergonomic CLIs) installs globally
  and is available to all agents.
- AXI's **executable tooling is PromptScript-based**, so it installs **per-project**
  (global install prints the expected `PromptScript does not support global` note for
  that part — see [skills.md](skills.md)).

## Existing AXI tools you can try

```bash
npx -y gh-axi                 # GitHub operations (cheaper than GitHub MCP)
npx -y chrome-devtools-axi    # browser automation
```

Add to a project as a skill: `skills add kunchenguid/<tool> --skill <name>`.

## Gotcha

- Don't reach for an MCP server by reflex. Benchmark a CLI/AXI alternative first — it's
  often dramatically cheaper and faster.
