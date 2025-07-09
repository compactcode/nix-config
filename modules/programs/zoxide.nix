{delib, ...}:
delib.module {
  # smart cd with jumping
  name = "progams.zoxide";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
    };
  };
}
