{delib, ...}:
delib.module {
  # wallpaper
  name = "services.hyprpaper";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.hyprpaper.enable = true;

    # automatic styling
    stylix.targets.hyprpaper.enable = true;
  };
}
