{delib, ...}:
delib.module {
  # pdf viewer
  name = "programs.zathura";

  options = {myconfig, ...}: {
    programs.zathura = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    programs.zathura.enable = true;
  };
}
