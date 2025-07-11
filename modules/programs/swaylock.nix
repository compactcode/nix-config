{delib, ...}:
delib.module {
  # screen locker
  name = "progams.swaylock";

  options = {myconfig, ...}:
    with delib; {
      enable = boolOption myconfig.services.hyprland.enable;
    };

  home.ifEnabled = {
    programs.swaylock.enable = true;
  };
}
