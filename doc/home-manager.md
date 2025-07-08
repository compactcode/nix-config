# Home Manager

## 1. Overview
This project uses [denix](https://github.com/yunfachi/denix) to configure home manager modules.

## 2. Module Layout
- `modules/programs/cli/*.nix`: Configuration for command line applications.
- `modules/programs/gui/*.nix`: Configuration for graphical applications.

## 3. Module Structure
Use this code as an example when modifying a home manager module.

```nix
{delib, ...}:
delib.module {
  name = "programs.cli.bat";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    # home manager options go in here e.g:
    programs.bat = {
      enable = true;
    };

    home = {
      shellAliases = {
        b = "bat";
      };
    };
  };
}
```

Prefer using `programs` or `services` wrappers over using `home.packages`.
