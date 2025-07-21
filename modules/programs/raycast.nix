{delib, ...}:
delib.module {
  # launcher
  name = "programs.raycast";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "raycast"
      ];
    };
  };
}
