{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.treesitter";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    # find calls to external classes
    extraFiles."after/queries/ruby/textobjects.scm".text = ''
      ; extends
      (call
        receiver: [
           (constant) @external_call
           (scope_resolution) @external_call
         ]
      )
    '';

    # language parsing
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
      treesitter-refactor = {
        enable = true;
        # rename local variable
        smartRename = {
          enable = true;
          keymaps.smartRename = "<leader>cr";
        };
      };
      # language query extensions (used by mini.ai)
      treesitter-textobjects = {
        enable = true;
        # jump to nodes
        move = {
          enable = true;
          gotoNextEnd = {
            "]e" = "@external_call";
          };
          gotoNextStart = {
            "]f" = "@function.outer";
            "]c" = "@class.outer";
          };
        };
        # use mini.ai instead
        select.enable = false;
        # move nodes
        swap = {
          enable = true;
          swapNext = {
            "<leader>cea" = "@parameter.inner";
            "<leader>cef" = "@function.outer";
          };
        };
      };
    };

    # make move commands repeatable
    extraConfigLua = ''
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    '';
  };
}
