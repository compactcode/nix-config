{delib, ...}:
delib.module {
  # notifications
  name = "services.mako";

  options = {myconfig, ...}: {
    services.mako = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    services.mako = {
      enable = true;
      settings = {
        # auto hide after 10 seconds
        defaultTimeout = 10 * 1000;
        # many application icons are ugly & unhelpful
        icons = false;
      };
    };

    # automatic styling
    stylix.targets.mako.enable = true;
  };
}
