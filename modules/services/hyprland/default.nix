{delib, ...}:
delib.module {
  # window manager
  name = "services.hyprland";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.hyprland = {
      enable = true;
      # use systemd
      withUWSM = true;
    };
  };

  home.ifEnabled = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        input = {
          # remap capslock to control
          kb_options = "ctrl:nocaps";
        };

        monitor = [
          # use default monitor resolutions
          ",preferred,auto,1"
        ];

        misc = {
          # disable built in logo
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        windowrulev2 = [
          # auto assign apps to workspaces
          "workspace 5, class:^(Slack)$"
          "workspace 9, class:^(steam)$"
        ];

        workspace = [
          # auto create floating terminal on scratchpad
          "special:scratchpad, on-created-empty:kitty"
        ];
      };
    };

    xdg = {
      dataFile = {
        # focus or create given application on a workspace
        "hyprland/focus.sh" = {
          executable = true;
          source = ./scripts/focus.sh;
        };

        # focus or create given project on a workspace
        "hyprland/project.sh" = {
          executable = true;
          source = ./scripts/project.sh;
        };
      };
    };
  };
}
