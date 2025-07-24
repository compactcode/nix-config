# Code Structure and Conventions

## Overview

This project uses [denix](https://github.com/yunfachi/denix) to configure modules.

## Project Layout

- `docs/*.md`: for documentation
- `features/*.nix`: for configuring related sets of modules
- `hosts/*.nix`: for host configuration
- `modules/base/*.nix`: for top level modules e.g. boot, xdg
- `modules/config/*.nix`: for denix configuration
- `modules/hardware/*.nix`: for hardware configuration
- `modules/programs/*.nix`: for program configuration
- `modules/programs/nixvim/*.nix`: for nixvim configuration
- `modules/services/*.nix`: for service configuration

## Module Structure

Modules are generally correspond to upstream counterparts in nixpkgs/home-manager.

### Example Module

```nix
{delib, ...}:
delib.module {
  name = "programs.chromium";

  # modules are disabled by default
  options = delib.singleEnableOption false;

  # nix-darwin only options go here, if relevant
  darwin.ifEnabled = {
    homebrew.casks = [
      "chromium"
    ];
  };

  # nixos only options go here, if relevant
  nixos.ifEnabled = {
    programs.chromium.enable = true;
  };

  # home-manager only options go here, if relevant
  home.ifEnabled = {
    programs.chromium.extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
}
```


### Module Options

Configuration options can be declared by a module.

```nix
{delib, ...}:
delib.module {
  name = "programs.example";

  options.programs.example = with delib; {
    enable = boolOption false;
    # option with default
    default = strOption "default";
    # required option
    required = noDefault (strOption null);
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment = {
      sessionVariables = {
        # use cfg to access internal options
        DEFAULT = cfg.default;
        REQUIRED = cfg.required;
      };
    };
  };
}
```

You can request full documentation for [denix options here](https://yunfachi.github.io/denix/options/introduction).

### Using Options

Options are typically set at the host or feature level using `myconfig`.

```nix
{delib, ...}:
delib.host {
  name = "pheonix";

  myconfig = {
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NF0NA04068A";
    };
  };
}
```

### Referencing Options

Configuration can be referenced by other modules via the `myconfig` argument.

```nix
delib.module {
  name = "users";

  options.users.primary = with delib; {
    id = strOption homeManagerUser;
    name = strOption "Shanon McQuay";
    email = strOption "hi@shan.dog";
    sshkey = strOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF";
  };
};

{delib, ...}:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption false;

  home.ifEnabled = {myconfig, ...}: {
    programs.git = {
      enable = true;
      # use myconfig to access options from another module
      userName = myconfig.users.primary.name;
      userEmail = myconfig.users.primary.email;
      extraConfig = {
        user.signingkey = myconfig.users.primary.sshkey;
      };
    };
  };
}
```


## Features

Features are high-level groupings of related modules that are enabled as a set to avoid having to duplicate them across all hosts.

### Example Feature

```nix
{delib, ...}:
delib.module {
  # hyprland desktop and dependencies
  name = "features.hyprland";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs = {
      hyprland.enable = true;
      rofi.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
    };
    services = {
      cliphist.enable = true;
      greetd.enable = true;
      hyprpaper.enable = true;
      mako.enable = true;
      polkit-gnome.enable = true;
      swayidle.enable = true;
    };
  };
}
```

### Example Feature Usage

In host configurations, features like this:

```nix
myconfig = {
  features = {
    hyprland.enable = true;
  };
};
```

## Conventions

### Formatting

* Use 2 spaces for indentation (never tabs)

### Testing

* Use `nh os build` to test the configuration on linux systems.
* Use `nh darwin build` to test the configuration on darwin systems.

### Nix Code

* Do not use `imports`.

### Git Commits

* Use compact lowercase titles.
* Use conventional commits with no scopes.
  * Types: build:, chore:, ci:, docs:, style:, refactor:, perf:, test:
