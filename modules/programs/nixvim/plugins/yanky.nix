{delib, ...}:
delib.module {
  # clipboard manager
  name = "programs.nixvim.plugins.yanky";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "<c-n>";
        action = "<Plug>(YankyPreviousEntry)";
        mode = ["n"];
        options = {desc = "cycle to previous yanky entry";};
      }
      {
        key = "<c-e>";
        action = "<Plug>(YankyNextEntry)";
        mode = ["n"];
        options = {desc = "cycle to next yanky entry";};
      }
      {
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        mode = ["n" "x"];
        options = {desc = "paste using yanky";};
      }
      {
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        mode = ["n" "x"];
        options = {desc = "paste using yanky";};
      }
      {
        key = "<leader>p";
        action = "<cmd>YankyRingHistory<cr>";
        options = {desc = "paste from history";};
      }
    ];

    plugins.yanky = {
      enable = true;
      settings = {
        system_clipboard = {
          # TODO: this keeps spamming clipboard permission requests
          sync_with_ring = false;
        };
      };
    };
  };
}
