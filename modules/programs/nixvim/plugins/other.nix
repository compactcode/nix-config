{
  delib,
  pkgs,
  ...
}:
delib.module {
  # find related files
  name = "programs.nixvim.plugins.other";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "<leader>o";
        action = "<cmd>Other<cr>";
        options = {desc = "open alternate file";};
      }
    ];

    extraPlugins = [
      pkgs.vimPlugins.other-nvim
    ];

    extraConfigLua = ''
      require("other-nvim").setup({
        mappings = {
          "rails",
        },
      })
    '';
  };
}
