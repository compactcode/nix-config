{delib, ...}:
delib.module {
  # video player
  name = "programs.mpv";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.mpv.enable = true;

    # automatic styling
    stylix.targets.mpv.enable = true;
  };
}
