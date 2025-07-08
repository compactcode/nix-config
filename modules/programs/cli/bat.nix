{delib, ...}:
delib.module {
  # cat replacement
  name = "programs.cli.bat";

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
