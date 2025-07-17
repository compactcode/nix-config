# System Configuration

## 1. Overview

This project is a nix flake that provides system configuration for several machines across both linux and mac.

- [denix](https://github.com/yunfachi/denix) provides an opinionated library and structure for organising configuration
- [nixpkgs](https://github.com/NixOS/nixpkgs) provides system configuration for linux only
- [nix-darwin](https://github.com/nix-darwin/nix-darwin) provides system configuration for mac only
- [home-manager](https://github.com/nix-community/home-manager) provides user configuration for all platforms
- [stylix](https://github.com/nix-community/stylix) provides theming for all platforms
- [nixvim](https://github.com/nix-community/nixvim) provides neovim configuration

## 2. Structure

```
.
├── doc/
├── flake.nix
├── hosts/
├── modules/
│   ├── base/
│   ├── config/
│   ├── hardware/
│   ├── programs/
│   └── services/
└── rices/
```

## 3. Hosts

* [alchemist](./hosts/alchemist/default.nix) - apple macbook pro
* [prophet](./hosts/prophet/default.nix) - lenovo thinkpad p43s
* [pheonix](./hosts/pheonix/default.nix) a custom built desktop pc

## 3. Modules

- `modules/config/*.nix`: for denix configuration
- `modules/hardware/*.nix`: for hardware configuration
- `modules/programs/*.nix`: for program configuration
- `modules/programs/nixvim/*.nix`: for nixvim configuration
- `modules/services/*.nix`: for service configuration
- `modules/base/*.nix`: for everything else

- Modules attempt to configure and match those available in nixpkgs/home-manager/nix-darwin

## 4. Module Structure

This is an example of a module.

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
