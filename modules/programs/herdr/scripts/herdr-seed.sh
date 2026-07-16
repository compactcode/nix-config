#!/usr/bin/env bash
# herdr-seed.sh — seed a herdr workspace for a project, mirroring the kitty
# session-basic/devenv split:
#   basic:  editor(nvim) · shell · git(lazygit) · ai(claude)
#   devenv: editor · shell · processes(devenv up) · git · logs · ai
#
# Usage: herdr-seed.sh [project-dir] (default $PWD). Needs a running herdr and jq.
set -euo pipefail

PROJECT_DIR=$(cd "${1:-$PWD}" && pwd)
LABEL=$(basename "$PROJECT_DIR")

command -v jq >/dev/null || { echo "herdr-seed: jq is required" >&2; exit 1; }
if ! herdr workspace list >/dev/null 2>&1; then
  echo "herdr-seed: no running herdr server — start one with \`herdr\` first." >&2
  exit 1
fi

# tab sets as "label|command" (empty = plain shell); devenv tabs load direnv
de() { echo "eval \"\$(direnv export zsh)\" && $1"; }
basic_tabs=(
  "editor|nvim"
  "shell|"
  "git|lazygit"
  "ai|claude"
)
devenv_tabs=(
  "editor|$(de nvim)"
  "shell|"
  "processes|$(de 'devenv up')"
  "git|$(de lazygit)"
  "logs|"
  "ai|$(de claude)"
)

# devenv projects often have no flake.nix, so also match devenv.nix/yaml/.envrc
is_devenv() {
  local d=$1
  if [ -f "$d/devenv.nix" ] || [ -f "$d/devenv.yaml" ]; then return 0; fi
  if [ -f "$d/.envrc" ] && grep -q devenv "$d/.envrc"; then return 0; fi
  if [ -f "$d/flake.nix" ] && grep -q 'cachix/devenv' "$d/flake.nix"; then return 0; fi
  return 1
}
if is_devenv "$PROJECT_DIR"; then
  session=devenv
  tabs=("${devenv_tabs[@]}")
else
  session=basic
  tabs=("${basic_tabs[@]}")
fi

# first value for a field anywhere in the response JSON (envelope-agnostic)
hid() { jq -r --arg k "$1" '[.. | objects | .[$k]? // empty] | first // empty'; }

# create the workspace (also yields its first tab + root pane)
ws=$(herdr workspace create --cwd "$PROJECT_DIR" --label "$LABEL" --focus)
WS_ID=$(printf '%s' "$ws" | hid workspace_id)
TAB1=$(printf '%s' "$ws" | hid tab_id)
PANE1=$(printf '%s' "$ws" | hid pane_id)
[ -n "$WS_ID" ] || { echo "herdr-seed: workspace create returned no id: $ws" >&2; exit 1; }

# reuse the workspace's initial tab for the first spec, create the rest
first=1
for spec in "${tabs[@]}"; do
  label=${spec%%|*}
  cmd=${spec#*|}
  if [ "$first" -eq 1 ]; then
    herdr tab rename "$TAB1" "$label" >/dev/null
    pane=$PANE1
    first=0
  else
    created=$(herdr tab create --workspace "$WS_ID" --cwd "$PROJECT_DIR" --label "$label" --focus)
    pane=$(printf '%s' "$created" | hid pane_id)
  fi
  [ -n "$cmd" ] && [ -n "$pane" ] && herdr pane run "$pane" "$cmd"
done

herdr tab focus "$TAB1" >/dev/null 2>&1 || true  # land back on the first tab
echo "herdr-seed: seeded $session workspace '$LABEL' ($WS_ID)"
