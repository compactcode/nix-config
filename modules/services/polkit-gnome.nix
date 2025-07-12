{delib, ...}:
delib.module {
  # authentication agent
  name = "services.polkit-gnome";

  options = {myconfig, ...}: {
    services.polkit-gnome = with delib; {
      enable = boolOption myconfig.services.hyprland.enable;
    };
  };

  home.ifEnabled = {
    services.polkit-gnome.enable = true;
  };
}
