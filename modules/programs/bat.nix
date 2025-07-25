{delib, ...}:
delib.module {
  # cat replacement
  name = "programs.bat";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.shellAliases = {
      b = "bat";
    };

    programs.bat = {
      enable = true;
    };

    # automatic styling
    stylix.targets.bat.enable = true;
  };
}
