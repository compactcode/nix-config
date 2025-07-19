{delib, ...}:
delib.module {
  # window manager
  name = "programs.hyprland";

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
        "$mod" = "SUPER";

        animation = [
          # slide scratchpads in vertically
          "specialWorkspace, 1, 10, default, slidevert"
        ];

        input = {
          # remap capslock to control
          kb_options = "ctrl:nocaps";
        };

        bind = [
          # applications tied to particular workspaces
          "$mod, a, exec, ~/.local/share/rofi/project.sh"
          "$mod, e, exec, ~/.local/share/hyprland/project.sh 3"
          "$mod, n, exec, ~/.local/share/hyprland/focus.sh 1 firefox firefox"
          "$mod, o, exec, ~/.local/share/hyprland/focus.sh 4 obsidian obsidian"
          "$mod, r, exec, ~/.local/share/hyprland/focus.sh 5 Slack slack"
          "$mod, s, exec, ~/.local/share/hyprland/project.sh 2"

          # applications
          "$mod, i, exec, rofi -show drun"
          "$mod, b, exec, ~/.local/share/rofi/bookmark.sh"
          "$mod, t, exec, kitty"
          "$mod, f, exec, kitty yazi"
          "$mod, p, exec, grimblast --notify edit area"
          "$mod, v, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

          # focused window actions
          "$mod, w, togglefloating,"
          "$mod, q, killactive,"

          # open scratchpad
          "$mod, c, togglespecialworkspace, scratchpad"

          # open workspaces
          "$mod, TAB, workspace, previous"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          # move windows
          "$mod+Shift, 1, movetoworkspace, 1"
          "$mod+Shift, 2, movetoworkspace, 2"
          "$mod+Shift, 3, movetoworkspace, 3"
          "$mod+Shift, 4, movetoworkspace, 4"
          "$mod+Shift, 5, movetoworkspace, 5"
          "$mod+Shift, 6, movetoworkspace, 6"
          "$mod+Shift, 7, movetoworkspace, 7"
          "$mod+Shift, 8, movetoworkspace, 8"
          "$mod+Shift, 9, movetoworkspace, 9"
        ];

        bindm = [
          # move windows with left mouse
          "$mod, mouse:272, movewindow"
          # resize windows with right mouse
          "$mod, mouse:273, resizewindow"
        ];

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

    # automatic styling
    stylix.targets.hyprland.enable = true;

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

      portal = {
        config.hyprland.default = [
          "hyprland"
          "gtk" # fallback for filepicker
        ];
      };
    };
  };
}
