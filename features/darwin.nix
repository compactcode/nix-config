{delib, ...}:
delib.module {
  # darwin desktop and dependencies
  name = "features.darwin";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    homebrew.enable = true;
    programs = {
      _1password.enable = true;
      atlassian-cli.enable = true;
      claude-desktop.enable = true;
      kitty.enable = true;
      bruno.enable = true;
      obsidian.enable = true;
      raycast.enable = true;
      slack.enable = true;
    };
    services.aerospace.enable = true;
  };
}
