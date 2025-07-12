{delib, ...}:
delib.module {
  # clipboard manager
  name = "services.cliphist";

  options = {myconfig, ...}: {
    services.cliphist = with delib; {
      enable = boolOption myconfig.services.hyprland.enable;
    };
  };

  home.ifEnabled = {
    services.cliphist.enable = true;
  };
}
