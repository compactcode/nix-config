#!/bin/bash
set -euo pipefail

TAB_TITLE=$1
shift

kitty @ --to $KITTY_LISTEN_ON send-text --match-tab title:"$TAB_TITLE" "$@" >/dev/null
