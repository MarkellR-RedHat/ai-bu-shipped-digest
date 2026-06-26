#!/bin/bash
# -------------------------------------------------------
# shipped-digest installer
# Copies slash commands into ~/.claude/commands/ so they
# are available globally in Claude Code.
# -------------------------------------------------------

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

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

echo ""
echo "shipped-digest installer"
echo "========================"
echo ""

# Create commands directory if it does not exist
if [ ! -d "$COMMANDS_DIR" ]; then
  echo "Creating $COMMANDS_DIR ..."
  mkdir -p "$COMMANDS_DIR"
fi

# Install each command, showing progress
INSTALLED=0
FAILED=0
for cmd in "${COMMANDS[@]}"; do
  SRC="$SCRIPT_DIR/commands/${cmd}.md"
  if [ -f "$SRC" ]; then
    cp "$SRC" "$COMMANDS_DIR/${cmd}.md"
    echo "  installed  /${cmd}"
    INSTALLED=$((INSTALLED + 1))
  else
    echo "  SKIPPED    /${cmd}  (source file not found)"
    FAILED=$((FAILED + 1))
  fi
done

echo ""

if [ "$FAILED" -gt 0 ]; then
  echo "WARNING: ${FAILED} command(s) could not be installed. Check that"
  echo "the commands/ directory is intact and try again."
  echo ""
fi

echo "${INSTALLED} commands installed to ${COMMANDS_DIR}"
echo ""
echo "Restart Claude Code to pick up the new commands, then try:"
echo ""
echo "  /shipped <owner>/<repo> last week"
echo ""
