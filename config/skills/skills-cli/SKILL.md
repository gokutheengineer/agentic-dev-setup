---
name: skills-cli
description: Add, list, update, or remove agent skills with the `skills` CLI (npx skills). Use when the user wants to install a skill from a repo, scaffold a new skill, or manage installed skills across agents. Includes the rule against installing unvetted internet skills.
---

# skills-cli — manage the open agent-skills ecosystem

`skills` is aliased to `npx -y skills@latest` (runs on demand, no global install).

```bash
skills add <owner>/<repo>            # install a skill package to your agents
skills add <repo> -g                 # install globally (all projects)
skills add <repo> --skill <name>     # just one skill from a repo
skills add <repo> -l                 # list a repo's skills without installing
skills list  /  skills list -g       # show installed (project / global)
skills find <query>                  # search the ecosystem
skills update                        # update installed skills
skills remove <name>                 # uninstall
skills init <name>                   # scaffold a new SKILL.md (or use skill-creator)
```

## Rules

- **Security (Kun's rule):** never install an internet skill that *claims* to boost your
  agent without published, rigorous evidence — skills run with full agent permissions and
  popularity ≠ quality. Prefer first-party or skills you've read.
- **Doc skills install globally; PromptScript (executable) skills are per-project** — the
  `PromptScript does not support global skill installation` line is expected, not an error.
- This repo's own skills live in `config/skills/` and are linked by `setup.sh local-skills`
  (not via the CLI). To author a new one, use the **skill-creator** skill.
