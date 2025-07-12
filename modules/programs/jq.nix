{delib, ...}:
delib.module {
  # json manipulation
  name = "programs.jq";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.jq = {
      enable = true;
    };
  };
}
