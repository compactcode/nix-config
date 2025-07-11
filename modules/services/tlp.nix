{delib, ...}:
delib.module {
  # power saving
  name = "services.tlp";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.tlp.enable = true;
  };
}
