{
  delib,
  homeconfig,
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

      # recognise slim-rails files
      # https://github.com/slim-template/slim-rails/blob/a6ae6b27d625b3703d9447cb5737b7007ce7874e/lib/slim-rails/register_engine.rb#L34
      autoCmd = [
        {
          event = ["BufRead" "BufNewFile"];
          pattern = "*.slim";
          command = "set filetype=slim";
        }
      ];

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      globals = {
        mapleader = " ";
        maplocalleader = "\\";
      };

      # vanilla keymaps
      keymaps = [
        {
          key = "<c-left>";
          action = "<C-w>h";
        }
        {
          key = "<c-down>";
          action = "<C-w>j";
        }
        {
          key = "<c-up>";
          action = "<C-w>k";
        }
        {
          key = "<c-right>";
          action = "<C-w>l";
        }
        {
          key = "<leader>aa";
          action = "<cmd>! ${homeconfig.xdg.configHome}/kitty/scripts/tab-send.sh aider /add % \n<cr>";
          options = {
            desc = "send the current file to the aider kitty tab";
            silent = true;
          };
        }
        {
          key = "<leader>uc";
          action = "<cmd>nohlsearch<cr>";
          options = {desc = "clear search highlight";};
        }
        {
          key = "<leader>fc";
          action = "<cmd>let @+ = expand('%')<cr>";
          options = {desc = "copy the current path to clipboard";};
        }
        {
          key = "<leader>w";
          action = "<cmd>w<cr>";
          options = {desc = "save file";};
        }
        {
          key = "<leader>W";
          action = "<cmd>wa<cr>";
          options = {desc = "save all files";};
        }
        {
          key = "<leader>y";
          action = "\"+y";
          options = {desc = "copy to system clipboard";};
        }
        {
          key = "<leader>q";
          action = "<cmd>qa!<cr>";
          options = {desc = "exit immediately";};
        }
      ];

      # base options
      opts = {
        backup = false; # disable file versioning
        expandtab = true; # convert tabs to spaces
        ignorecase = true; # ignore case by default
        foldenable = false; # disable code folding
        list = true; # enable listchars
        listchars = {
          nbsp = "+"; # display non breaking spaces
          tab = ">~"; # display tabs
          trail = "·"; # display any trailing spaces
        };
        number = true; # show line numbers
        shiftwidth = 2; # use 2 spaces for tab
        smartcase = true; # don't ignore case if a capital is typed
        softtabstop = 2; # use 2 spaces for tab
        swapfile = false; # disable file versioning
        tabstop = 2; # use 2 spaces for tab
        writebackup = false; # disable file versioning
      };

      plugins = {
        # lazy loading
        lz-n.enable = true;
      };

      withNodeJs = false;
      withPerl = false;
      withRuby = false;
    };

    home = {
      shellAliases = {
        v = "nvim";
      };
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
