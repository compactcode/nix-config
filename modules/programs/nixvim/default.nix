{
  delib,
  inputs,
  lib,
  pkgs,
  ...
}:
delib.module {
  # code editor
  name = "programs.nixvim";

  options = delib.singleEnableOption true;

  home.always.imports = [inputs.nixvim.homeManagerModules.nixvim];

  home.ifEnabled = {
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      plugins = {
        # lazy loading
        lz-n.enable = true;
      };

      withNodeJs = false;
      withPerl = false;
      withRuby = false;
    };

    xdg = lib.mkIf (pkgs.stdenv.isLinux) {
      # add launcher for neovim
      desktopEntries.nvim = {
        categories = ["Utility" "TextEditor"];
        exec = "kitty -e nvim";
        genericName = "Text Editor";
        icon = "nvim";
        name = "Neovim";
      };
    };
  };
}
