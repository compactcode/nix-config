# Neovim

## 1. Overview
This project uses [nixvim](https://github.com/nix-community/nixvim) to configure neovim.

## 2. Nixvim Layout
- `modules/programs/nixvim/default.nix`: is the entry point
- `modules/programs/nixvim/plugin/*.nix`: contains a file for each plugin

Modules are imported automatically by convention.

## 3. Plugin Structure
Use this code as an example when modifying a plugin.

```nix
{delib, ...}:
delib.module {
  # language parsing
  name = "programs.nixvim.plugins.treesitter";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        # highlight embedded lua
        nixvimInjections = true;
        settings = {
          # replace default highlighting
          highlight.enable = true;
          # replace default indenting
          indent.enable = true;
        };
      };
    };
  };
}
```

## 4. Rules

- When adding a new module, only create the module, DO NOT attempt to import anything.
