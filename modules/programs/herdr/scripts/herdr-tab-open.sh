#!/usr/bin/env bash
# herdr-tab-open.sh — focus-or-create a tab by name in the focused workspace.
# The herdr analogue of kitty's tab-open.sh, driven over the socket API.
#
# Usage: herdr-tab-open.sh <label> [command...]
#   e.g. herdr-tab-open.sh git lazygit
set -euo pipefail

LABEL=$1; shift
command -v jq >/dev/null || { echo "herdr-tab-open: jq is required" >&2; exit 1; }

hid() { jq -r --arg k "$1" '[.. | objects | .[$k]? // empty] | first // empty'; }

# Scope to the focused workspace so a tab named "git" in another workspace
# never steals the jump (mirrors the current-window scoping in the kitty script).
WS_ID=$(herdr workspace list | jq -r '[.. | objects | select(.focused==true) | .workspace_id] | first // empty')

# Existing tab with this label in that workspace? (only TabInfo has pane_count,
# so this never matches a pane that happens to share the label)
TAB_ID=$(herdr tab list ${WS_ID:+--workspace "$WS_ID"} \
  | jq -r --arg l "$LABEL" '[.. | objects | select(.label==$l and has("pane_count")) | .tab_id] | first // empty')

if [ -n "$TAB_ID" ]; then
  herdr tab focus "$TAB_ID"
else
  created=$(herdr tab create ${WS_ID:+--workspace "$WS_ID"} --label "$LABEL" --focus)
  if [ $# -gt 0 ]; then
    pane=$(printf '%s' "$created" | hid pane_id)
    [ -n "$pane" ] && herdr pane run "$pane" "$*"
  fi
fi
