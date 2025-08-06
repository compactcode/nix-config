{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.gluetun";

  options.services.gluetun = with delib; {
    enable = boolOption false;
    ports = listOfOption port [];
    serviceName = readOnly (strOption "podman-gluetun.service");
  };

  # dependencies
  myconfig.ifEnabled = {
    services.nfs.shares.config.enable = true;
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = myconfig.services.gluetun.ports;

    # ensure containers start after nfs mount
    systemd.services.podman-gluetun = {
      after = [myconfig.services.nfs.shares.config.mountUnit];
      requires = [myconfig.services.nfs.shares.config.mountUnit];
    };

    virtualisation.oci-containers.containers.gluetun = {
      # allow network creation
      devices = [
        "/dev/net/tun:/dev/net/tun"
      ];
      environmentFiles = [
        "${myconfig.services.nfs.shares.config.mountPath}/gluetun/secret.env" # not managed by nix
      ];
      environment = {
        SERVER_COUNTRIES = "Australia";
      };
      # allow network creation
      extraOptions = [
        "--cap-add=NET_ADMIN"
      ];
      image = "ghcr.io/qdm12/gluetun:v3.38.0";
      ports = lib.map (p: "${toString p}:${toString p}") myconfig.services.gluetun.ports;
    };
  };
}
