{delib, ...}:
delib.module {
  # shell prompt
  name = "programs.cli.starship";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.starship = {
      enable = true;
    };
  };
}
