{delib, ...}:
delib.module {
  # video player
  name = "programs.mpv";

  options = {myconfig, ...}: {
    programs.mpv = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    programs.mpv.enable = true;
  };
}
