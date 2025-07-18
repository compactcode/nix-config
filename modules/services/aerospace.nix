{delib, ...}:
delib.module {
  # window manager
  name = "services.aerospace";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    services.aerospace = {
      enable = true;

      settings = {
        accordion-padding = 30;
        default-root-container-layout = "accordion";
        default-root-container-orientation = "auto";

        gaps = {
          inner.horizontal = 8;
          inner.vertical = 8;
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 8;
          outer.right = 8;
        };

        mode.main.binding = {
          alt-shift-ctrl-cmd-1 = "workspace 1";
          alt-shift-ctrl-cmd-2 = "workspace 2";
          alt-shift-ctrl-cmd-3 = "workspace 3";
          alt-shift-ctrl-cmd-4 = "workspace 4";
          alt-shift-ctrl-cmd-5 = "workspace 5";
          alt-shift-ctrl-cmd-6 = "workspace 6";
          alt-shift-ctrl-cmd-7 = "workspace 7";
          alt-shift-ctrl-cmd-8 = "workspace 8";
          alt-shift-ctrl-cmd-9 = "workspace 9";
          alt-shift-ctrl-cmd-0 = "workspace 10";

          alt-shift-ctrl-cmd-s = "exec-and-forget open -a ~/Applications/Home\\ Manager\\ Apps/Slack.app";
          alt-shift-ctrl-cmd-t = "exec-and-forget open -a ~/Applications/Home\\ Manager\\ Apps/Kitty.app";
          alt-shift-ctrl-cmd-c = "exec-and-forget open -a /System/Applications/Calendar.app";

          alt-shift-ctrl-cmd-m = "exec-and-forget open -a /System/Applications/Mail.app";
          alt-shift-ctrl-cmd-n = "exec-and-forget open -a /Applications/Google\\ Chrome.app";
          alt-shift-ctrl-cmd-o = "exec-and-forget open -a ~/Applications/Home\\ Manager\\ Apps/Obsidian.app";

          alt-shift-ctrl-1 = "move-node-to-workspace 1";
          alt-shift-ctrl-2 = "move-node-to-workspace 2";
          alt-shift-ctrl-3 = "move-node-to-workspace 3";
          alt-shift-ctrl-4 = "move-node-to-workspace 4";
          alt-shift-ctrl-5 = "move-node-to-workspace 5";
          alt-shift-ctrl-6 = "move-node-to-workspace 6";
          alt-shift-ctrl-7 = "move-node-to-workspace 7";
          alt-shift-ctrl-8 = "move-node-to-workspace 8";
          alt-shift-ctrl-9 = "move-node-to-workspace 9";
          alt-shift-ctrl-0 = "move-node-to-workspace 10";

          alt-shift-ctrl-a = "layout accordion horizontal vertical";
          alt-shift-ctrl-t = "layout tiles horizontal vertical";

          alt-shift-ctrl-m = "focus left";
          alt-shift-ctrl-n = "focus down";
          alt-shift-ctrl-e = "focus up";
          alt-shift-ctrl-i = "focus right";
        };

        on-window-detected = [
          {
            "if".app-id = "com.google.chrome";
            run = ["move-node-to-workspace 1"];
          }

          {
            "if".app-id = "md.obsidian";
            run = ["move-node-to-workspace 4"];
          }

          {
            "if".app-id = "com.apple.mail";
            run = ["move-node-to-workspace 10"];
          }

          {
            "if".app-id = "com.tinyspeck.slackmacgap";
            run = ["move-node-to-workspace 10"];
          }
        ];

        workspace-to-monitor-force-assignment = {
          "1" = "main";
          "2" = "main";
          "3" = "main";
          "4" = "main";
          "5" = "main";
          "6" = "main";
          "7" = "main";
          "8" = "main";
          "9" = "main";
          "10" = ["secondary" "main"];
        };
      };
    };
  };
}
