{delib, ...}:
delib.module {
  # darwin specific tools
  name = "features.darwin";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.raycast.enable = true;
    services.aerospace.enable = true;
  };
}
