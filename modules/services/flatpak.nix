{delib, ...}:
delib.module {
  name = "services.flatpak";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.flatpak.enable = true;
  };
}
