{
  config,
  delib,
  pkgs,
  ...
}:
delib.module {
  # window manager
  name = "programs.hyprland";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # TODO: Consider somewhere to put general wayland configuration like this.
    # Ensure electron applications use wayland.
    environment.variables.NIXOS_OZONE_WL = "1";

    programs.hyprland.enable = true;
  };

  home.ifEnabled = {
    # clipboard cli for the shell and agents
    home.packages = [pkgs.wl-clipboard];

    wayland.windowManager.hyprland = {
      enable = true;
      # reuse the nixos package rather than installing a second build, and let
      # nixos provide the portal (its config already falls back to gtk)
      package = config.programs.hyprland.package;
      portalPackage = null;
      # hyprlang configs are no longer supported as of 0.57
      configType = "lua";
      settings = {
        config = {
          input = {
            # remap capslock to control
            kb_options = "ctrl:nocaps";
          };

          misc = {
            # disable built in logo
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
        };

        animation = [
          # slide scratchpads in vertically
          {
            leaf = "specialWorkspace";
            enabled = true;
            speed = 10;
            bezier = "default";
            style = "slidevert";
          }
        ];

        monitor = [
          # use default monitor resolutions
          {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = 1;
          }
        ];

        window_rule = [
          # auto assign apps to workspaces
          {
            match.class = "^(Slack)$";
            workspace = "5";
          }
          {
            match.class = "^(signal)$";
            workspace = "6";
          }
          {
            match.class = "^(steam)$";
            workspace = "9";
          }
        ];
      };

      # keybinds and event handlers
      extraLuaFiles.user = ./hyprland.lua;
    };

    # automatic styling
    stylix.targets.hyprland.enable = true;
  };
}
