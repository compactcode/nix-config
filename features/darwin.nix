{delib, ...}:
delib.module {
  # darwin desktop and dependencies
  name = "features.darwin";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs = {
      _1password.enable = true;
      bruno.enable = true;
      obsidian.enable = true;
      raycast.enable = true;
      slack.enable = true;
    };
    services.aerospace.enable = true;
  };
}
