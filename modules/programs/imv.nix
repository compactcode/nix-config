{delib, ...}:
delib.module {
  # image viewer
  name = "programs.imv";

  options = {myconfig, ...}: {
    programs.imv = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    programs.imv.enable = true;
  };
}
