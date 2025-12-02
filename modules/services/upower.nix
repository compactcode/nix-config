{delib, ...}:
delib.module {
  # battery status
  name = "services.upower";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.upower.enable = true;
  };
}
