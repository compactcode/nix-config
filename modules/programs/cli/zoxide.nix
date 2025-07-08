{delib, ...}:
delib.module {
  # smart cd with jumping
  name = "programs.cli.zoxide";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
    };
  };
}
