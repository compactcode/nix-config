#!/usr/bin/env bash

main() {
  projects=$(zoxide query -l | rg "$XDG_PROJECTS_DIR")

  selected=$(echo "${projects}" | walker --dmenu -p 'Projects')

  if [[ -n $selected ]]; then
    if rg -q cachix/devenv "$selected/flake.nix"; then
      hyprctl dispatch "hl.dsp.exec_cmd([==[kitty -d '$selected' --session session-devenv.conf]==])"
    else
      hyprctl dispatch "hl.dsp.exec_cmd([==[kitty -d '$selected' --session session-basic.conf]==])"
    fi
  fi
}

main
