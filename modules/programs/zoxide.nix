{delib, ...}:
delib.module {
  # smart cd with jumping
  name = "programs.zoxide";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
