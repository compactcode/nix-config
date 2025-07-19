{delib, ...}:
delib.module {
  # clipboard manager
  name = "services.cliphist";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.cliphist.enable = true;
  };
}
