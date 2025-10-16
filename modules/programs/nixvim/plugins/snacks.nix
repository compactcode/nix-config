{delib, ...}:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.snacks";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      # {
      #   key = "<leader>t";
      #   action = "<cmd>lua Snacks.terminal.toggle()<cr>";
      #   mode = ["n"];
      #   options = {desc = "open terminal";};
      # }
      {
        key = "<C-/>";
        action = "<cmd>close<cr>";
        mode = ["t"];
        options = {desc = "hide terminal";};
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
          ui_select = false;
        };

        # terminal utilities
        terminal = {
          enable = true;
        };
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
