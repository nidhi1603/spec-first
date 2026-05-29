#!/usr/bin/env bash
# spec-first — installer for Claude Code skills
# Installs the four spec-first skills into your user-level Claude skills directory
# so they're available in every project.
#
# Usage:
#   ./install.sh                  # install all skills
#   ./install.sh project-interrogator spec-reviewer   # install a subset
#
# Or one-liner (from a clone):
#   bash install.sh

set -euo pipefail

SKILLS_DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/skills"

ALL_SKILLS=(project-interrogator spec-reviewer scope-guard ship-check)

if [ "$#" -gt 0 ]; then
  SELECTED=("$@")
else
  SELECTED=("${ALL_SKILLS[@]}")
fi

mkdir -p "$SKILLS_DEST"

echo "Installing spec-first skills into: $SKILLS_DEST"
echo

for skill in "${SELECTED[@]}"; do
  if [ ! -d "$SRC/$skill" ]; then
    echo "  ! skipping '$skill' — not found in $SRC"
    continue
  fi
  rm -rf "${SKILLS_DEST:?}/$skill"
  cp -R "$SRC/$skill" "$SKILLS_DEST/$skill"
  echo "  ✓ $skill"
done

echo
echo "Done. Restart Claude Code (or start a new session) to pick up the skills."
echo "Try it: tell Claude \"I want to build something\" — project-interrogator should kick in."
