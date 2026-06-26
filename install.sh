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
cp "$SCRIPT_DIR/commands/shipped-narrative.md" "$COMMANDS_DIR/shipped-narrative.md"
cp "$SCRIPT_DIR/commands/shipped-celebration.md" "$COMMANDS_DIR/shipped-celebration.md"
cp "$SCRIPT_DIR/commands/shipped-delta.md" "$COMMANDS_DIR/shipped-delta.md"

echo ""
echo "Installed 9 commands:"
echo ""
echo "  Core digests:"
echo "  /shipped                - Story-driven changelog digest for a repo"
echo "  /shipped-email          - Stakeholder email a VP would read and forward"
echo "  /shipped-slack          - Slack message with mrkdwn formatting, ready to paste"
echo "  /shipped-release-notes  - GitHub Release-style notes for CHANGELOG or release pages"
echo "  /shipped-compare        - Cross-repo comparison with unified analysis"
echo "  /shipped-metrics        - Pure quantitative metrics and health indicators"
echo ""
echo "  New commands:"
echo "  /shipped-narrative      - 3-5 paragraph narrative for all-hands and blog posts"
echo "  /shipped-celebration    - Team highlight reel with shoutouts for Slack"
echo "  /shipped-delta          - Period-over-period trend analysis with deltas"
echo ""
echo "Reference templates are in the reference/ and formats/ directories."
echo ""
echo "Done. Restart Claude Code to pick up the new commands."
