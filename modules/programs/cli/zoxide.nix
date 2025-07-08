{delib, ...}:
delib.module {
  # smart cd with jumping
  name = "programs.cli.zoxide";

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
    };
  };
}
