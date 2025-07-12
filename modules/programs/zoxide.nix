{delib, ...}:
delib.module {
  # smart cd with jumping
  name = "programs.zoxide";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
    };
  };
}
