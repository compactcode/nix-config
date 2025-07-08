{delib, ...}:
delib.module {
  # cat replacement
  name = "programs.cli.bat";

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
