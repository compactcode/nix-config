{delib, ...}:
delib.module {
  # cat replacement
  name = "programs.bat";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.bat = {
      enable = true;
    };

    home = {
      shellAliases = {
        b = "bat";
      };
    };
  };
}
