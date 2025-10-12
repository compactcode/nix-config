{delib, ...}:
delib.module {
  # file explorer
  name = "programs.nixvim.plugins.oil";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "<leader>e";
        action = "<cmd>Oil<cr>";
        options = {desc = "explore files";};
      }
    ];

    plugins.oil = {
      enable = true;

      settings = {
        # dont prompt when making non destructive changes
        skip_confirm_for_simple_edits = true;
        view_options = {
          # show files and directories starting with "."
          show_hidden = true;
        };
      };

      # delay loading until requested
      lazyLoad.settings = {
        cmd = "Oil";
      };
    };
  };
}
