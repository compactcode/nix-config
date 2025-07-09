{delib, ...}:
delib.module {
  # json manipulation
  name = "progams.jq";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.jq = {
      enable = true;
    };
  };
}
