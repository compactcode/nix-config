{delib, ...}:
delib.module {
  # wallpaper
  name = "services.hyprpaper";

  options = {myconfig, ...}: {
    services.hyprpaper = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    services.hyprpaper.enable = true;

    # automatic styling
    stylix.targets.hyprpaper.enable = true;
  };
}
