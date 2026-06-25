#!/usr/bin/env bash
#
# sync-opinions.sh — mirror Kun. Pull Kun Chen's (kunchenguid) LATEST writing and
# refresh OPINIONS.md so his evolving views stay adopted as mine.
#
# Manual by design: run it whenever you want an update. It edits
# config/skills/opinions/SKILL.md and leaves the change UNCOMMITTED so you can review
# the diff (and the drift report) before committing.
#
#   ./scripts/sync-opinions.sh
#
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$REPO_ROOT/config/skills/opinions/SKILL.md"

if ! command -v claude >/dev/null 2>&1; then
  echo "claude (Claude Code) not found on PATH." >&2; exit 1
fi

read -r -d '' PROMPT <<'EOF' || true
You are updating my OPINIONS.md, which deliberately MIRRORS Kun Chen (kunchenguid):
his durable software/product/engineering opinions are adopted as mine.

Do this:
1. Use WebSearch and WebFetch to find Kun Chen's (kunchenguid) RECENT public writing —
   primarily his Substack at https://blog.kunchenguid.com (check the archive / latest
   posts) and any recent posts you can find under the handle "kunchenguid". Read the
   most recent ones.
2. Extract only DURABLE opinions and principles about software, agents, AI tools,
   testing, architecture, tooling ergonomics, product, engineering craft, management,
   and career. EXCLUDE jokes, one-off reactions, code snippets, recipes, and
   implementation details.
3. Merge findings into config/skills/opinions/SKILL.md, written in FIRST PERSON as my
   beliefs. REORGANIZE sections as needed rather than blindly appending. Keep it a
   clean living map, not a changelog.
4. DRIFT REPORT: if any newly found opinion CONTRADICTS what's already in the file,
   do NOT silently overwrite — print a "DRIFT DETECTED" section listing each conflict
   (old vs new) so I can decide. Default to keeping the newer stance in the file but
   flag it clearly.
5. NEVER modify the "## My divergences from Kun" section — that is mine and overrides
   everything above it. Leave it exactly as-is.
6. Do not commit. Leave the file edited so I can review the diff myself.

The file to edit is: config/skills/opinions/SKILL.md
EOF

echo "==> Syncing OPINIONS.md from Kun's latest writing (this calls Claude Code)..."
cd "$REPO_ROOT"
claude -p "$PROMPT" \
  --allowedTools "WebSearch,WebFetch,Read,Edit,Write" \
  || { echo "claude run failed; OPINIONS.md unchanged." >&2; exit 1; }

echo
echo "==> Done. Review the change before committing:"
git -C "$REPO_ROOT" --no-pager diff --stat -- "$SKILL" || true
echo "    git diff -- config/skills/opinions/SKILL.md"
echo "    git add -A && git commit -m 'Sync OPINIONS.md from Kun'"
