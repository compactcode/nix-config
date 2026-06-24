{delib, ...}:
delib.module {
  # container runtime (docker daemon) for macos
  name = "programs.colima";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      brews = [
        "colima"
      ];
    };
  };
}
