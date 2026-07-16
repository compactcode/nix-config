#!/usr/bin/env bash
# herdr-seed.sh — seed a herdr workspace for a project.
#
# Detects a devenv project (devenv.nix/devenv.yaml, a devenv .envrc, or a
# flake.nix referencing cachix/devenv) and seeds the devenv session; otherwise
# seeds the basic session — mirroring the kitty session-basic/devenv split.
#
#   basic:  editor(nvim) · shell · git(lazygit) · ai(claude)
#   devenv: editor · shell · processes(devenv up) · git · logs · ai
#           (devenv tabs run inside the direnv environment)
#
# Usage: herdr-seed.sh [project-dir]   (defaults to $PWD)
#
# Requires a running herdr server (just run `herdr` first) and jq.
set -euo pipefail

PROJECT_DIR=$(cd "${1:-$PWD}" && pwd)
LABEL=$(basename "$PROJECT_DIR")

command -v jq >/dev/null || { echo "herdr-seed: jq is required" >&2; exit 1; }
if ! herdr workspace list >/dev/null 2>&1; then
  echo "herdr-seed: no running herdr server — start one with \`herdr\` first." >&2
  exit 1
fi

# Tab sets as "label|command" (empty command = plain shell). devenv tabs load
# the direnv environment first, matching kitty's session-devenv.conf.
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

# Detect the session for this project. devenv projects commonly use
# devenv.nix/devenv.yaml with a `use devenv` .envrc and no flake.nix, so match
# any of those as well as a flake.nix that pulls in cachix/devenv.
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

# First id of a given field, wherever it sits in the response JSON. Robust to
# whether the CLI wraps results in an envelope or returns them flat.
hid() { jq -r --arg k "$1" '[.. | objects | .[$k]? // empty] | first // empty'; }

# Create the workspace (this also gives us its first tab + root pane).
ws=$(herdr workspace create --cwd "$PROJECT_DIR" --label "$LABEL" --focus)
WS_ID=$(printf '%s' "$ws" | hid workspace_id)
TAB1=$(printf '%s' "$ws" | hid tab_id)
PANE1=$(printf '%s' "$ws" | hid pane_id)
[ -n "$WS_ID" ] || { echo "herdr-seed: workspace create returned no id: $ws" >&2; exit 1; }

# Seed each tab: reuse the workspace's initial tab for the first spec, create the
# rest, and run each tab's command (if any) in its pane.
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
