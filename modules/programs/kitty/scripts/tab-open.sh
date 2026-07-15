#!/usr/bin/env bash
set -euo pipefail

TAB_TITLE=$1
shift

# `kitty @ ls` can list tabs from every window sharing this connection, so restrict the
# search to the current window (KITTY_WINDOW_ID) and only act on tabs there.
TAB_ID=$(kitty @ ls | jq -r --arg title "$TAB_TITLE" --arg window "${KITTY_WINDOW_ID:-}" '
  first(
    .[]                                                        # each window
    | select(any(.tabs[].windows[].id; tostring == $window))  # ours
    | .tabs[] | select(.title == $title) | .id                # matching tab id
  ) // empty
')

if [ -n "$TAB_ID" ]; then
  # focus by id; title alone can be ambiguous
  kitty @ focus-tab --match "id:$TAB_ID"
elif [ $# -gt 0 ]; then
  # no match: create the tab running the given command
  kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current "$@"
else
  # no match: create a plain tab
  kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current
fi
