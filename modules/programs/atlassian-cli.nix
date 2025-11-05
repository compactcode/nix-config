{delib, ...}:
delib.module {
  # cli access to atlassian products
  name = "programs.atlassian-cli";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      brews = [
        "acli"
      ];
      taps = [
        "atlassian/homebrew-acli"
      ];
    };
  };
}
