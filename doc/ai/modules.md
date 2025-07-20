# Modules

## 1. Overview

This project uses [denix](https://github.com/yunfachi/denix) to configure modules.

## 2. Module Layout

- `modules/config/*.nix`: for denix configuration
- `modules/hardware/*.nix`: for hardware configuration
- `modules/programs/*.nix`: for program configuration
- `modules/programs/nixvim/*.nix`: for nixvim configuration
- `modules/services/*.nix`: for service configuration
- `modules/base/*.nix`: for everything else
- `features/*.nix`: for feature sets that enable modules

Modules are imported automatically by convention.

## 3. Module Structure

Use this code as an example when modifying a module.

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
    };
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

## 4. Module Options

Use this code as a guide when adding options for denix modules.

```nix
{delib, ...}:
delib.module {
  name = "programs.grimblast";

  options.programs.grimblast = with delib; {
    # disabled by default
    enable = boolOption false;
    editor = strOption "pinta";
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment = {
      sessionVariables = {
        # use cfg to access internal options
        GRIMBLAST_EDITOR = cfg.editor;
      };
      systemPackages = [pkgs.grimblast];
    };
  };
}
```

### Example using config from another module

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
};
```

You can request full documentation for [denix options here](https://yunfachi.github.io/denix/options/introduction).

## 5. Features

Features are high-level groupings of related modules that can be enabled together. They are defined in `features/` and allow for easy configuration of common use cases.

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

In host configurations, enable features like this:

```nix
myconfig = {
  features = {
    hyprland.enable = true;
  };
};
```

### Available Features

- `features.development`: Development tools including direnv, gh, nixvim plugins etc
- `features.hyprland`: A complete Hyprland desktop environment

## 6. Rules

- Disable modules by default (`delib.singleEnableOption false`).
- DO NOT use lib.mkOption, lib.mkForce etc.
- DO NOT use imports
