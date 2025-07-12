{delib, ...}:
delib.module {
  # screen locker
  name = "progams.swaylock";

  options = {myconfig, ...}: {
    programs.swaylock = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    programs.swaylock.enable = true;
  };

  nixos.ifEnabled = {
    # allow swaylock to perform authentication
    security.pam.services.swaylock = {};
  };
}
