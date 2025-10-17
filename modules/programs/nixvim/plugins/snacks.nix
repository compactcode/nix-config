{delib, ...}:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.snacks";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          snacks = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>cu";
        action = "<cmd>lua Snacks.picker.lsp_references()<cr>";
        options = {desc = "show lsp references";};
      }
      {
        key = "<leader>fo";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options = {desc = "find last edited files";};
      }
      {
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.resume()<cr>";
        options = {desc = "resume last search";};
      }
      {
        key = "<leader>fs";
        action = "<cmd>lua Snacks.picker.grep({hidden=true})<cr>";
        options = {desc = "search project";};
      }
      {
        key = "<leader>fw";
        action = "<cmd>lua Snacks.picker.grep_word({hidden=true})<cr>";
        options = {desc = "search project for current word";};
      }
      {
        key = "<leader>t";
        action = "<cmd>lua Snacks.picker.files({hidden=true})<cr>";
        options = {desc = "find files";};
      }
      {
        key = "<leader><space>";
        action = "<cmd>lua Snacks.picker.files({hidden=true})<cr>";
        options = {desc = "find files";};
      }
    ];

    plugins.snacks = {
      enable = true;

      settings = {
        # upgrade input prompt
        input = {
          enable = true;
        };

        # finder
        picker = {
          enable = true;
          # use for system generated selections
          ui_select = true;
        };
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
