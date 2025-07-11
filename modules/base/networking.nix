{delib, ...}:
delib.module {
  name = "networking";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    networking = {
      # enable firewall
      firewall.enable = true;

      # detect and manage network connections
      networkmanager.enable = true;
    };
  };
}
