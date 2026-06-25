{delib, ...}:
delib.module {
  # issue tracking and project management
  name = "programs.linear";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "linear"
      ];
    };
  };
}
