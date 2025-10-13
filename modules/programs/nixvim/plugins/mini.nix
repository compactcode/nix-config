{delib, ...}:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.mini";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "<leader>e";
        action = "<cmd>lua MiniFiles.open()<cr>";
        options = {desc = "explore files";};
      }
      {
        key = "<leader>E";
        action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>";
        options = {desc = "explore files";};
      }
      {
        key = "<leader>ff";
        action = "<cmd>lua MiniExtra.pickers.visit_paths()<cr>";
        options = {desc = "find commonly edited files";};
      }
      {
        key = "<leader>fo";
        action = "<cmd>lua MiniExtra.pickers.oldfiles()<cr>";
        options = {desc = "find last edited files";};
      }
      {
        key = "<leader>fO";
        action = "<cmd>lua MiniExtra.pickers.oldfiles({current_dir = true})<cr>";
        options = {desc = "find last edited files";};
      }
    ];

    plugins.mini = {
      enable = true;

      mockDevIcons = true;

      modules = {
        # text objects
        ai = {
          n_lines = 500;
          custom_textobjects = {
            # manipulate a class
            c.__raw = ''
              require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
            '';
            # manipulate a function
            f.__raw = ''
              require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
            '';
            # manipulate a code block
            o.__raw = ''
              require("mini.ai").gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
              })
            '';
          };
        };
        align = {}; # text alignment
        # common configuration
        basics = {
          basic = true; # smart search, disable backups etc
          extra_ui = true; # list chars, menu style etc
          mappings = {
            # common key bindings
            basic = true;
            # place toggles under the ui menu
            option_toggle_prefix = "<leader>u";
          };
        };
        extra = {}; # extra finders etc
        files = {
          # show preview of selected file
          windows.preview = true;
        };
        icons = {}; # icon provider
        indentscope = {}; # indent decorations
        pick = {}; # finder
        pairs = {}; # auto pairs
        surround = {}; # surround actions
        visits = {}; # file tracking
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
