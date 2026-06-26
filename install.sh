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

echo "Installed commands:"
echo "  /shipped         - Generate a changelog digest for a repo"
echo "  /shipped-compare - Compare what shipped across multiple repos"
echo "  /shipped-email   - Generate a stakeholder email from shipped changes"
echo ""
echo "Done. Restart Claude Code to pick up the new commands."
