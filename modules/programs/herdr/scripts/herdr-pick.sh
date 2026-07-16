#!/usr/bin/env bash
# herdr-pick.sh — pick a project with zoxide/fzf, then focus-or-create its
# workspace. Meant to run in a temporary herdr pane (a keybind command).
set -euo pipefail

SCRIPTS=$(cd "$(dirname "$0")" && pwd)

list=$(zoxide query -l 2>/dev/null || true)
# scope to project dirs when XDG_PROJECTS_DIR is set (fall back to all)
if [ -n "${XDG_PROJECTS_DIR:-}" ]; then
  filtered=$(printf '%s\n' "$list" | grep -F "$XDG_PROJECTS_DIR" || true)
  [ -n "$filtered" ] && list=$filtered
fi

dir=$(printf '%s\n' "$list" | fzf --prompt="workspace> " --height=100%) || exit 0
[ -n "$dir" ] || exit 0

exec "$SCRIPTS/herdr-open.sh" "$dir"
