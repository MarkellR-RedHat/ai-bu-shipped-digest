#!/bin/bash
# install.sh - Install shipped-digest commands into Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing shipped-digest commands..."

mkdir -p "$COMMANDS_DIR"

cp "$SCRIPT_DIR/commands/shipped.md" "$COMMANDS_DIR/shipped.md"
cp "$SCRIPT_DIR/commands/shipped-compare.md" "$COMMANDS_DIR/shipped-compare.md"
cp "$SCRIPT_DIR/commands/shipped-email.md" "$COMMANDS_DIR/shipped-email.md"
cp "$SCRIPT_DIR/commands/shipped-slack.md" "$COMMANDS_DIR/shipped-slack.md"
cp "$SCRIPT_DIR/commands/shipped-release-notes.md" "$COMMANDS_DIR/shipped-release-notes.md"
cp "$SCRIPT_DIR/commands/shipped-metrics.md" "$COMMANDS_DIR/shipped-metrics.md"

echo "Installed commands:"
echo "  /shipped              - Generate a changelog digest for a repo"
echo "  /shipped-compare      - Compare what shipped across multiple repos"
echo "  /shipped-email        - Generate a stakeholder email from shipped changes"
echo "  /shipped-slack        - Generate a Slack-ready message with emoji formatting"
echo "  /shipped-release-notes - Generate GitHub Release-style release notes"
echo "  /shipped-metrics      - Generate a pure quantitative metrics report"
echo ""
echo "Format templates are available in the formats/ directory for reference."
echo ""
echo "Done. Restart Claude Code to pick up the new commands."
