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

      # language query extensions (used by mini.ai)
      treesitter-textobjects = {
        enable = true;
        settings = {
          # jump to nodes
          move = {
            enable = true;
            goto_next_end = {
              "]e" = "@external_call";
            };
            goto_next_start = {
              "]f" = "@function.outer";
              "]c" = "@class.outer";
            };
          };
          # use mini.ai instead
          select.enable = false;
          # move nodes
          swap = {
            enable = true;
            swap_next = {
              "<leader>cea" = "@parameter.inner";
              "<leader>cef" = "@function.outer";
            };
          };
        };
      };
    };

    # TODO: re-enable once nixvim syncs fix for nvim-treesitter-textobjects
    # https://github.com/nix-community/nixvim/issues/4145
    # extraConfigLua = ''
    #   local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    #
    #   vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    #   vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    # '';
  };
}
