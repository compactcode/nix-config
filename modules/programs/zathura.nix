{delib, ...}:
delib.module {
  # pdf viewer
  name = "programs.zathura";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.zathura.enable = true;

    # automatic styling
    stylix.targets.zathura.enable = true;
  };
}
