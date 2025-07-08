{delib, ...}:
delib.module {
  # json manipulation
  name = "programs.cli.jq";

  home.ifEnabled = {
    programs.jq = {
      enable = true;
    };
  };
}
