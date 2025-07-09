{delib, ...}:
delib.module {
  # enhanced versions of builtin motions
  name = "programs.nixvim.plugins.flash";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "S";
        action = "<cmd>lua require(\"flash\").treesitter()<cr>";
        options = {desc = "select using treesitter";};
      }
    ];

    plugins.flash = {
      enable = true;

      # add jump labels to the default search
      settings.modes.search.enabled = true;

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
