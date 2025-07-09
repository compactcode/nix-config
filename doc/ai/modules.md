# Modules

## 1. Overview
This project uses [denix](https://github.com/yunfachi/denix) to configure modules.

## 2. Module Layout
- `modules/programs/*.nix`: for program configuration
- `modules/services/*.nix`: for service configuration

Modules are imported automatically by convention.

## 3. Module Structure
Use this code as an example when modifying a module.

```nix
{delib, ...}:
delib.module {
  name = "programs.bat";

  options = delib.singleEnableOption true;

  # darwin options go here, remove if not relevant
  darwin.ifEnabled = {
    homebrew = {
      enable = true;
    };
  };

  # nixos options go here, remove if not relevant
  nixos.ifEnabled = {
    boot.zfs = {
      enable = true;
    };
  };

  # home manager options go here, remove if not relevant
  home.ifEnabled = {
    programs.bat = {
      enable = true;
    };
  };
}
```

## 4. Rules

- Prefer using `programs` or `services` wrappers where possible.
- When adding a new module, only create the module, DO NOT attempt to import anything.
