{delib, ...}:
delib.module {
  name = "homebrew";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    # self-updating casks (1password, claude) leave root-owned bundles that brew can't replace
    environment.variables.HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS = "1";

    homebrew = {
      enable = true;
      onActivation = {
        # nuke anything we didn't configure
        cleanup = "zap";
      };
    };
  };
}
