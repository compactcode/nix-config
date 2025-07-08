{delib, ...}:
delib.module {
  # shell prompt
  name = "programs.cli.starship";

  home.ifEnabled = {
    programs.starship = {
      enable = true;
    };
  };
}
