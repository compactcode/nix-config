{delib, ...}:
delib.module {
  # status bar and notifications for hyprland
  name = "programs.hyprpanel";

  options = delib.singleEnableOption false;

  # dependencies
  myconfig.ifEnabled = {
    # needed for battery status
    services.upower.enable = true;
  };

  home.ifEnabled = {
    programs.hyprpanel = {
      enable = true;

      settings = {
        bar = {
          clock.format = "%a %b %d  %I:%M %p";

          layouts = {
            "*" = {
              left = [
                "dashboard"
                "workspaces"
              ];
              middle = [
                "clock"
              ];
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
        };

        menus = {
          clock = {
            time = {
              hideSeconds = true;
            };

            # not used
            weather.enabled = false;
          };

          dashboard = {
            # not used
            directories.enabled = false;
            # not used
            shortcuts.enabled = false;
          };
        };

        # not used
        wallpaper.enable = false;

        # the default was too large (on 1080p at least)
        theme.font.size = "1.0rem";
      };
    };

    # automatic styling
    stylix.targets.hyprpanel.enable = true;
  };
}
