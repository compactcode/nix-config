{delib, ...}:
delib.module {
  # network manager tray
  name = "services.network-manager-applet";

  options = {myconfig, ...}: {
    services.network-manager-applet = with delib; {
      enable = boolOption myconfig.programs.waybar.enable;
    };
  };

  home.ifEnabled = {
    services.network-manager-applet.enable = true;
  };
}
