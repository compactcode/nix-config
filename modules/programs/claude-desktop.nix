{delib, ...}:
delib.module {
  # cli access to atlassian products
  name = "programs.claude-desktop";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "claude"
      ];
    };
  };
}
