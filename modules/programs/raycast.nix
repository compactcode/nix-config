{delib, ...}:
delib.module {
  # launcher
  name = "programs.raycast";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "raycast"
      ];
    };
  };
}
