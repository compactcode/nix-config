{delib, ...}:
delib.module {
  # status bar and notifications for hyprland
  name = "programs.hyprpanel";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    # needed for battery status
    services.upower.enable = true;
  };

  home.ifEnabled = {
    programs.hyprpanel = {
      enable = true;

      settings = {
        bar.layouts = {
          "*" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["clock"];
            right = [
              "cputemp"
              "network"
              "volume"
              "battery"
              "bluetooth"
              "notifications"
              "systray"
            ];
          };
        };

        menus.clock = {
          time = {
            hideSeconds = true;
          };
          weather.enabled = false;
        };

        theme.font.size = "1.0rem";
      };
    };

    # automatic styling
    stylix.targets.hyprpanel.enable = true;
  };
}
