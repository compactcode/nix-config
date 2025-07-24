{delib, ...}:
delib.module {
  name = "services.homeassistant";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8123];

    # ensure container starts after nfs mount
    systemd.services.podman-homeassistant = {
      after = ["mnt-nfs-config.mount"];
      requires = ["mnt-nfs-config.mount"];
    };

    virtualisation.oci-containers.containers.homeassistant = {
      image = "lscr.io/linuxserver/homeassistant:2024.7.2";
      ports = ["8123:8123"];
      volumes = [
        "/mnt/nfs/config/homeassistant:/config"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        # allow device discovery on the host network
        "--network=host"
      ];
    };
  };
}
