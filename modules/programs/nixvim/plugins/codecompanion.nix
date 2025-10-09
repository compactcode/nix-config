{delib, ...}:
delib.module {
  # ai assistant
  name = "programs.nixvim.plugins.codecompanion";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim = {
    keymaps = [
      {
        key = "<leader>aa";
        action = "<cmd>CodeCompanionChat Add<cr>";
        mode = ["v"];
        options = {desc = "add selection to context";};
      }
      {
        key = "<leader>ar";
        action = "<cmd>CodeCompanionActions<cr>";
        mode = ["n"];
        options = {desc = "actions";};
      }
      {
        key = "<leader>at";
        action = "<cmd>CodeCompanionChat toggle<cr>";
        mode = ["n"];
        options = {desc = "chat";};
      }
    ];

    plugins.codecompanion = {
      enable = true;

      settings = {
        adapters = {
          http = {
            gemini = {
              # use 1password to retrieve api key
              __raw = ''
                function()
                  return require('codecompanion.adapters').extend('gemini', {
                    env = {
                      api_key = "cmd:op read op://personal/google/aistudio-api-key --no-newline"
                    },
                  })
                end
              '';
            };
          };

          acp = {
            claude_code = {
              # use nix installed acp over npx
              # see https://github.com/olimorris/codecompanion.nvim/blob/946e18627271e008635d53f96a56af459ebb40da/lua/codecompanion/adapters/acp/claude_code.lua#L19-L23
              __raw = ''
                function()
                  return require("codecompanion.adapters").extend("claude_code", {
                    commands = {
                      default = {
                        "claude-code-acp",
                      },
                    },
                  })
                end
              '';
            };
            gemini_cli = {
              # use 1password to retrieve api key
              __raw = ''
                function()
                  return require("codecompanion.adapters").extend("gemini_cli", {
                    defaults = {
                      auth_method = "gemini-api-key",
                    },
                    env = {
                      GEMINI_API_KEY = "cmd:op read op://personal/google/aistudio-api-key --no-newline"
                    },
                  })
                end
              '';
            };
          };
        };

        strategies = {
          cmd = {
            adapter = "gemini";
          };
          chat = {
            adapter = "gemini";
          };
          inline = {
            adapter = "gemini";
          };
        };
      };

      # delay loading until requested
      lazyLoad.settings = {
        cmd = [
          "CodeCompanion"
          "CodeCompanionActions"
          "CodeCompanionChat"
          "CodeCompanionCmd"
        ];
      };
    };
  };
}
