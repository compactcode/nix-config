#!/usr/bin/env bash
# herdr-open.sh — focus the workspace for a dir, or seed one if absent.
# The focus-or-create primitive shared by herdr-here.sh and herdr-pick.sh.
#
# Usage: herdr-open.sh [project-dir]   (defaults to $PWD)
set -euo pipefail

DIR=$(cd "${1:-$PWD}" && pwd)
LABEL=$(basename "$DIR")
SCRIPTS=$(cd "$(dirname "$0")" && pwd)

command -v jq >/dev/null || { echo "herdr-open: jq is required" >&2; exit 1; }

# match the workspace by label (only WorkspaceInfo has tab_count)
WS_ID=$(herdr workspace list \
  | jq -r --arg l "$LABEL" '[.. | objects | select(.label==$l and has("tab_count")) | .workspace_id] | first // empty')
if [ -n "$WS_ID" ]; then
  herdr workspace focus "$WS_ID" >/dev/null
else
  "$SCRIPTS/herdr-seed.sh" "$DIR" >/dev/null
fi
