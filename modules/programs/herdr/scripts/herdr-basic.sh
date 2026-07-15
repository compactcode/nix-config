#!/usr/bin/env bash
# herdr-basic.sh — seed a herdr workspace mirroring the kitty `basic` session.
#
# Tabs: editor(nvim) · shell(zsh) · git(lazygit) · ai(claude)
# Usage: herdr-basic.sh [project-dir]   (defaults to $PWD)
#
# Requires a running herdr server (just run `herdr` in a terminal first) and jq.
set -euo pipefail

PROJECT_DIR=$(cd "${1:-$PWD}" && pwd)
LABEL=$(basename "$PROJECT_DIR")

# --- preflight -------------------------------------------------------------
command -v jq >/dev/null || { echo "herdr-basic: jq is required" >&2; exit 1; }
if ! herdr workspace list >/dev/null 2>&1; then
  echo "herdr-basic: no running herdr server — start one with \`herdr\` first." >&2
  exit 1
fi

# First id of a given field, wherever it sits in the response JSON. Robust to
# whether the CLI wraps results in an envelope or returns them flat.
hid() { jq -r --arg k "$1" '[.. | objects | .[$k]? // empty] | first // empty'; }

run_in_tab() { # <tab-create-or-workspace-json> <command...>
  local json=$1; shift
  local pane; pane=$(printf '%s' "$json" | hid pane_id)
  [ -n "$pane" ] || { echo "herdr-basic: could not find pane id in: $json" >&2; return 1; }
  [ $# -gt 0 ] && herdr pane run "$pane" "$*"
}

# --- tab 1: editor (from the workspace's first tab) ------------------------
ws=$(herdr workspace create --cwd "$PROJECT_DIR" --label "$LABEL" --focus)
WS_ID=$(printf '%s' "$ws" | hid workspace_id)
TAB1=$(printf '%s' "$ws" | hid tab_id)
[ -n "$WS_ID" ] || { echo "herdr-basic: workspace create returned no id: $ws" >&2; exit 1; }
herdr tab rename "$TAB1" editor >/dev/null
run_in_tab "$ws" nvim

# --- remaining tabs --------------------------------------------------------
new_tab() { herdr tab create --workspace "$WS_ID" --cwd "$PROJECT_DIR" --label "$1" --focus; }

new_tab shell >/dev/null                       # plain zsh, nothing to run
run_in_tab "$(new_tab git)" lazygit
run_in_tab "$(new_tab ai)"  claude

herdr tab focus "$TAB1" >/dev/null 2>&1 || true  # land back on editor
echo "herdr-basic: seeded workspace '$LABEL' ($WS_ID) — editor · shell · git · ai"
