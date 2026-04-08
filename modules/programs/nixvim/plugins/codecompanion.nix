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
          acp = {
            claude_code = {
              __raw = ''
                function()
                  return require("codecompanion.adapters").extend("claude_code", {
                    env = {
                      CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://personal/claude/oauth_token --no-newline"
                    },
                  })
                end
              '';
            };
          };
        };

        interactions = {
          chat = {
            adapter = "claude_code";
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
