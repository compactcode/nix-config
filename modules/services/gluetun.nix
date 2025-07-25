{delib, ...}:
delib.module {
  name = "services.gluetun";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall for VPN services
    networking.firewall.allowedTCPPorts = [9696 9091]; # prowlarr and transmission

    # start after nfs mounts are available
    systemd.services.podman-gluetun = {
      after = ["mnt-nfs-config.mount"];
      requires = ["mnt-nfs-config.mount"];
    };

    virtualisation.oci-containers.containers.gluetun = {
      image = "qmcgaw/gluetun:v3.38.0";
      ports = [
        "9696:9696" # prowlarr
        "9091:9091" # transmission
      ];
      volumes = [
        "/mnt/nfs/config/gluetun:/gluetun"
      ];
      environment = {
        VPN_SERVICE_PROVIDER = "mullvad";
        VPN_TYPE = "wireguard";
        WIREGUARD_PRIVATE_KEY = "CHANGE_ME";
        WIREGUARD_ADDRESSES = "CHANGE_ME";
        SERVER_CITIES = "CHANGE_ME";
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--device=/dev/net/tun:/dev/net/tun"
      ];
    };
  };
}
