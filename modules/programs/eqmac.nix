{delib, ...}:
delib.module {
  # system-wide audio equaliser, used for software volume control when the output
  # device has none of its own (displayport audio to a fixed-level line out)
  name = "programs.eqmac";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "eqmac"
      ];
    };
  };
}
