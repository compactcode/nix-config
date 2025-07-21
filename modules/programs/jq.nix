{delib, ...}:
delib.module {
  # json manipulation
  name = "programs.jq";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.jq = {
      enable = true;
    };
  };
}
