{delib, ...}:
delib.module {
  # collection of plugins
  name = "programs.nixvim.plugins.mini";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
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
          # basic config like smart search
          basic = true;
        };
        icons = {}; # icon provider
        indentscope = {}; # indent decorations
        pairs = {}; # auto pairs
        surround = {}; # surround actions
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
