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

Modules are imported automatically by convention.

## 3. Module Structure
Use this code as an example when modifying a module.

```nix
{delib, ...}:
delib.module {
  name = "programs.chromium";

  # simple on/off flag
  options = delib.singleEnableOption true;

  # nix-darwin only options go here, if relevant
  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "chromium"
      ];
    };
  };

  # nixos only options go here, if relevant
  nixos.ifEnabled = {
    programs.chromium.enable = true;
  };

  # home-manager only options go here, if relevant
  home.ifEnabled = {
    programs.chromium = {
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };
}
```

## 4. Module Options
Use this code as a guide when adding options for denix modules.

```nix
{delib, ...}:
delib.module {
  name = "programs.grimblast";

  options = {myconfig, ...}: {
    programs.grimblast = with delib; {
      # access an option from another module.
      enable = boolOption myconfig.programs.hyprland.enable;
      editor = noDefault (strOption null);
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment = {
      sessionVariables = {
        # cfg gives access to options from options declared in this module
        GRIMBLAST_EDITOR = cfg.editor;
      };
      systemPackages = [pkgs.grimblast];
    };
  };
}
```

You can request full documentation for [denix options here](https://yunfachi.github.io/denix/options/introduction).

## 5. Rules

- Use denix options, do not use nixpkgs options (lib.mkOption etc).
- Prefer using `programs` or `services` wrappers where possible.
- When adding a new module, only create the module, DO NOT attempt to import anything.
