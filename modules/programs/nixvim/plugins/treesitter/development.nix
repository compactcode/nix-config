{
  delib,
  pkgs,
  ...
}:
delib.module {
  # language parsing
  name = "programs.nixvim.plugins.treesitter.development";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    # find calls to external classes
    extraFiles."after/queries/ruby/textobjects.scm".text =
      /*
      query
      */
      ''
        ; extends
        (call
          receiver: [
             (constant) @external_call
             (scope_resolution) @external_call
           ]
        )
      '';

    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          go
          python
          query
          ruby
          rust
          scss
          slim
          sql
          tsx
          typescript
        ];
      };

      # language based rename
      treesitter-refactor = {
        enable = true;
        # rename local variable
        settings = {
          smart_rename = {
            enable = true;
            keymaps.smart_rename = "<leader>cr";
          };
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
