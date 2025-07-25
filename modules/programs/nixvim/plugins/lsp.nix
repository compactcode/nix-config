{delib, ...}:
delib.module {
  # language server protocol
  name = "programs.nixvim.plugins.lsp";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          fidget = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = {desc = "code actions";};
      }
      {
        key = "<leader>ch";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options = {desc = "show info about symbol";};
      }
    ];

    plugins = {
      # general purpose linting
      efmls-configs = {
        enable = true;
        setup = {
          json = {
            linter = "jq";
          };
          yaml = {
            linter = "yamllint";
          };
        };
      };

      # lsp status notifications
      fidget = {
        enable = true;

        # background opacity
        settings = {
          notification.window.winblend = 0;
        };

        # delay loading until an lsp is attached
        lazyLoad.settings = {
          event = ["LspAttach"];
        };
      };

      # lsp servers
      lsp = {
        enable = true;

        # configured but not installed (projects provide their own)
        enabledServers = [
          # ruby
          {
            name = "ruby_lsp";
            extraOptions = {};
          }
        ];

        # configured and installed
        servers = {
          # bash
          bashls.enable = true;
          # general purpose
          efm = {
            enable = true;
            extraOptions = {
              init_options = {
                # conform handles formatting
                documentFormatting = false;
                documentRangeFormatting = false;
              };
            };
          };
          # html
          emmet_ls.enable = true;
          # nix
          nixd.enable = true;
          # html
          tailwindcss.enable = true;
        };

        # delay loading until a file is opened
        lazyLoad.settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
    };
  };
}
