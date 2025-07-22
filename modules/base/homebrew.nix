{delib, ...}:
delib.module {
  name = "homebrew";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      enable = true;
      onActivation = {
        # nuke anything we didn't configure
        cleanup = "zap";
      };
    };
  };
}
