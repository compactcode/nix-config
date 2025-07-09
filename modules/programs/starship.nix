{delib, ...}:
delib.module {
  # shell prompt
  name = "progams.starship";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.starship = {
      enable = true;
    };
  };
}
