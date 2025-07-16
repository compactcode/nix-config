{delib, ...}:
delib.module {
  # shell prompt
  name = "programs.starship";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # automatic styling
    stylix.targets.starship.enable = true;
  };
}
