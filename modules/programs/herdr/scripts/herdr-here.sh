#!/usr/bin/env bash
# herdr-here.sh — attach to herdr, focused on this directory's workspace.
#
# Ensures a persistent server is running, focuses the workspace whose label is
# this dir's basename (seeding it from herdr-seed.sh if it doesn't exist yet),
# then attaches. Safe to re-run: it re-focuses rather than duplicating.
#
# Usage: herdr-here.sh [project-dir]   (defaults to $PWD)
set -euo pipefail

DIR=$(cd "${1:-$PWD}" && pwd)
LABEL=$(basename "$DIR")
SCRIPTS=$(cd "$(dirname "$0")" && pwd)

command -v jq >/dev/null || { echo "herdr-here: jq is required" >&2; exit 1; }

# 1. ensure a persistent server so socket calls work before we attach
if ! herdr workspace list >/dev/null 2>&1; then
  nohup herdr server >/dev/null 2>&1 &
  disown 2>/dev/null || true
  for _ in $(seq 1 50); do
    herdr workspace list >/dev/null 2>&1 && break
    sleep 0.1
  done
  herdr workspace list >/dev/null 2>&1 \
    || { echo "herdr-here: server did not come up" >&2; exit 1; }
fi

# 2. focus-or-create the workspace for this dir (only WorkspaceInfo has tab_count)
WS_ID=$(herdr workspace list \
  | jq -r --arg l "$LABEL" '[.. | objects | select(.label==$l and has("tab_count")) | .workspace_id] | first // empty')
if [ -n "$WS_ID" ]; then
  herdr workspace focus "$WS_ID" >/dev/null
else
  "$SCRIPTS/herdr-seed.sh" "$DIR" >/dev/null
fi

# 3. attach
exec herdr
