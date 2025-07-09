{delib, ...}:
delib.module {
  # json manipulation
  name = "programs.cli.jq";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.jq = {
      enable = true;
    };
  };
}
