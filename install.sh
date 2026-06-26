#!/bin/bash
# install.sh - Install shipped-digest commands into Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing shipped-digest commands..."
echo ""

# Create commands directory if it does not exist
mkdir -p "$COMMANDS_DIR"

# List of commands to install
COMMANDS=(
  "shipped"
  "shipped-compare"
  "shipped-email"
  "shipped-slack"
  "shipped-release-notes"
  "shipped-metrics"
  "shipped-narrative"
  "shipped-celebration"
  "shipped-delta"
)

INSTALLED=0
for cmd in "${COMMANDS[@]}"; do
  if [ -f "$SCRIPT_DIR/commands/${cmd}.md" ]; then
    cp "$SCRIPT_DIR/commands/${cmd}.md" "$COMMANDS_DIR/${cmd}.md"
    INSTALLED=$((INSTALLED + 1))
  else
    echo "  Warning: commands/${cmd}.md not found, skipping"
  fi
done

echo "Installed ${INSTALLED} commands to ${COMMANDS_DIR}:"
echo ""
echo "  Core digests:"
echo "    /shipped                Story-driven digest grouped by themes"
echo "    /shipped-email          Stakeholder email a VP would forward"
echo "    /shipped-slack          Slack message, ready to paste"
echo "    /shipped-release-notes  GitHub Release notes with attribution"
echo "    /shipped-compare        Cross-repo comparison with unified analysis"
echo "    /shipped-metrics        Quantitative metrics and health indicators"
echo ""
echo "  Narrative and celebration:"
echo "    /shipped-narrative      Prose narrative for all-hands and blog posts"
echo "    /shipped-celebration    Team highlight reel with specific shoutouts"
echo "    /shipped-delta          Period-over-period trend analysis"
echo ""
echo "Reference templates are in the reference/ and formats/ directories."
echo ""
echo "Done. Restart Claude Code to pick up the new commands."
