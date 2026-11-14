# Vision

A minimal, declarative development environment that is fast, efficient and keyboard-centric. Terminal tools and automation let you work at the speed of thought, in a reproducible setup that makes experimenting safe.

## Guiding Principles

* **Minimal.** Keep it simple, with few moving parts.
* **Keyboard focused.** Use keyboard shortcuts to move at the speed of thought.
* **Terminal focused.** Prefer customisable terminal tools over all-in-one graphical apps.
* **Efficient.** Automate tasks you repeat often.
* **Declarative.** Keep environments reproducible and consistent so experiments are safe.
* **Secure.** Prevent compromise, and limit the damage when it happens.

# Hosts

| Host        | Platform       | Features                       |
| ----------- | -------------- | ------------------------------ |
| `alchemist` | aarch64-darwin | cli, development, darwin       |
| `pheonix`   | x86_64-linux   | cli, development, hyprland     |
| `prophet`   | x86_64-linux   | cli, development, hyprland     |
| `pudge`     | x86_64-linux   | cli, homelab                   |

Apply a configuration with `nh os switch` (NixOS) or `nh darwin switch` (macOS).

# Features

## Declarative

* **Nix flakes** pin every input for reproducible builds.
* **[denix](https://github.com/yunfachi/denix)** organises NixOS, nix-darwin and home-manager config into shared modules, grouped into features and enabled per host.
* **home-manager** manages dotfiles and user packages.
* **nixvim** manages Neovim and its plugins.
* **stylix** applies a shared theme ("rice") across apps.

## Keyboard-Driven

* **Window management:** Hyprland on Linux, AeroSpace on macOS.
* **Launcher:** walker on Linux, Raycast on macOS.
* **Terminal and editor:** kitty and a nixvim-built Neovim.

## Terminal Tools

* **Shell:** zsh with starship for the prompt and atuin for history search.
* **CLI tools:** eza, ripgrep, fd, fzf, zoxide, bat, delta, lazygit, jujutsu and yazi.

## Homelab

[`pudge`](doc/adr/homelab-containers.md) is a headless server that runs Home Assistant, Emby and a media stack as OCI containers through Podman, with data on NFS shares.

## Security

* **[Secret management](doc/adr/secrets.md):** secrets live in 1Password and are never stored on disk.

# Roadmap

* **Ergonomic keyboard system:** a consistent, layered shortcut system built on home row modifiers.
  * Support both Colemak-DH and QWERTY.
  * Keep bindings consistent from the OS through kitty and Neovim.
  * Add window management scripts, e.g. pin kitty tabs to workspaces and jump to them directly.

# Architectural Decision Records

Decisions are recorded as ADRs in [`doc/adr`](doc/adr). Start new ones from the [template](doc/adr/template.md).
