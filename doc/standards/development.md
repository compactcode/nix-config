# Development Standards

This project uses [denix](https://yunfachi.github.io/denix/) to organise NixOS, nix-darwin and home-manager configuration into modules. denix loads every file under `hosts`, `modules`, `rices` and `features` automatically.

## Project Layout

| Path                      | Purpose                                             |
| ------------------------- | --------------------------------------------------- |
| `hosts/<name>/`           | Host configuration                                  |
| `features/*.nix`          | Sets of related modules, enabled per host           |
| `modules/base/`           | Top-level system modules, e.g. boot, users, xdg     |
| `modules/hardware/`       | Hardware modules                                    |
| `modules/programs/`       | Program modules                                     |
| `modules/programs/nixvim/`| Neovim configuration and plugins                    |
| `modules/services/`       | Service modules                                     |
| `rices/<name>/`           | Themes, selected per host                           |
| `doc/`                    | Documentation                                       |

## Modules

A module usually matches its upstream counterpart in nixpkgs or home-manager, and is disabled by default.

```nix
{
  delib,
  pkgs, # only if needed
  ...
}:
delib.module {
  name = "programs.chromium";

  options = delib.singleEnableOption false;

  # nix-darwin only
  darwin.ifEnabled = {
    homebrew.casks = ["chromium"];
  };

  # nixos only
  nixos.ifEnabled = {
    programs.chromium.enable = true;
  };

  # home-manager only
  home.ifEnabled = {
    programs.chromium.extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
    ];
  };
}
```

### Options

A module can declare more options than `enable`. Read its own options with `cfg`, and another module's with `myconfig`. See the [denix options reference](https://yunfachi.github.io/denix/options/introduction).

```nix
{delib, ...}:
delib.module {
  name = "programs.example";

  options.programs.example = with delib; {
    enable = boolOption false;
    # string with a default
    greeting = strOption "hello";
    # required string
    device = noDefault (strOption null);
    # list of ports
    ports = listOfOption port [];
  };

  nixos.ifEnabled = {cfg, myconfig, ...}: {
    environment.sessionVariables = {
      # this module's option
      GREETING = cfg.greeting;
      # another module's option
      EMAIL = myconfig.users.primary.email;
    };
  };
}
```

## Features

A feature is a module that enables a set of related modules, so hosts do not repeat them.

```nix
{delib, ...}:
delib.module {
  name = "features.homelab";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.podman.enable = true;
    services = {
      emby.enable = true;
      homeassistant.enable = true;
    };
  };
}
```

## Hosts

A host picks a rice, enables features and sets options through `myconfig`.

```nix
{delib, ...}:
delib.host {
  name = "pheonix";
  rice = "catppuccin-mocha";

  myconfig = {
    features.hyprland.enable = true;
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-example";
    };
  };
}
```

## Conventions

### Nix Code

* Indent with 2 spaces, never tabs.
* Do not use `imports` in modules. Hosts may import external modules such as `nixos-hardware`.
* Take `pkgs` in the file's top-level arguments (`{delib, pkgs, ...}:`), not in the arguments of `ifEnabled`.
* Avoid `with pkgs;`. Reference packages directly, e.g. `pkgs.nfs-utils`.

### Testing

Build before you switch: `nh os build` on NixOS, `nh darwin build` on macOS.

### Git Commits

* Use [conventional commits](https://www.conventionalcommits.org) with a compact lowercase title.
* Scope the commit to the module it changes, e.g. `feat(hyprlock): unlock with fingerprint`. Omit the scope for repo-wide changes, e.g. `chore: update inputs`.
* Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `build`, `ci`, `style`, `perf`, `test`.
