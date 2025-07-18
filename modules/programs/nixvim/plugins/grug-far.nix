{delib, ...}:
delib.module {
  # search and replace
  name = "programs.nixvim.plugins.grug-far";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    plugins.grug-far = {
      enable = true;

      # delay loading until requested
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>cs";
          __unkeyed-2 = "<cmd>lua require(\"grug-far\").open()<cr>";
          desc = "search and replace";
        }
      ];
    };
  };
}
