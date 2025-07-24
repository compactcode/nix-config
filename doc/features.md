# Features

This document outlines the features that have been implemented to achieve our project's [vision](./vision.md).

## Declarative Environment

The entire system is managed declaratively using Nix, ensuring a reproducible, consistent, and experimental environment.

*   **Nix Flakes:** The project is built around a `flake.nix`, providing reproducible builds and dependency management.
*   **Declarative Home:** User-level configuration is managed declaratively with `home-manager`, ensuring dotfiles and user packages are consistent across systems.
*   **Declarative Neovim:** Neovim is configured declaratively using `nixvim`, allowing its configuration and dependencies to be versioned and managed alongside the rest of the system.

## Keyboard-Driven Workflow

The environment is heavily optimized for keyboard-centric operation, minimizing mouse usage and maximizing speed.

*   **Tiling Window Management:**
    *   **Hyprland:** Used on Linux for dynamic, keyboard-driven window tiling and workspace management.
    *   **Aerospace:** Used on macOS to provide a similar tiling window manager experience.
*   **Application Launcher:** `rofi` provides a fast, keyboard-driven way to launch applications, run scripts, and switch windows.
*   **Terminal & Editor:**
    *   `kitty` is the terminal emulator of choice, configured for performance and scriptability.
    *   `nixvim` provides a deeply customized Neovim setup with a rich set of plugins for a modal, keyboard-first editing experience.

## Terminal-Centric Tooling

We prefer powerful, composable terminal-based tools over monolithic graphical applications.

*   **Enhanced Shell:** `zsh` is paired with `starship` for a rich, informative prompt and `atuin` for powerful command history search.
*   **Modern CLI Tools:** The system includes a suite of modern, efficient command-line utilities, such as:
    *   `eza` (a modern `ls`)
    *   `ripgrep` (fast `grep` alternative)
    *   `fd` (simple `find` alternative)
    *   `fzf` (command-line fuzzy finder)
    *   `zoxide` (smarter `cd`)
    *   `bat` (a `cat` clone with wings)
    *   `lazygit` (a terminal UI for git)

## Automation & Efficiency

Repetitive tasks are automated to streamline workflows and reduce cognitive load.

## Security

In line with the principle of building a secure system, several features are in place to prevent and minimize damage from potential compromises.

*   **Secret Management:** Integration with `1Password` provides secure storage and retrieval of secrets.

## Minimalism and Performance

The selection of tools and configurations prioritizes speed, simplicity, and a low resource footprint.

*   **Lightweight Components:** The stack is built on lean components like `hyprland`, `rofi`, and `kitty` instead of a full desktop environment.
