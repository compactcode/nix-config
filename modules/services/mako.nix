{delib, ...}:
delib.module {
  # notifications
  name = "services.mako";

  options = {myconfig, ...}: {
    services.mako = with delib; {
      enable = boolOption myconfig.services.hyprland.enable;
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
  };
}
