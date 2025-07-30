{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.lualine";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        options = {
          component_separators = {
            left = "";
            right = "";
          };
        };

        # one status line for all windows
        globalstatus = true;

        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = [
            {
              __unkeyed = "filename";
              path = 1;
            }
          ];
          lualine_x = [
            {
              __unkeyed = "lsp_status";
              ignore_lsp = {
                __unkeyed = "efm";
              };
            }
            "diagnostics"
            "encoding"
            "fileformat"
            {
              __unkeyed = "filetype";
              colored = false;
            }
          ];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
      };
    };
  };
}
