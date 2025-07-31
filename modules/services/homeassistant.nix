{delib, ...}:
delib.module {
  name = "services.homeassistant";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    services.nfs.shares.config.enable = true;
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8123];

    # ensure container starts after nfs mount
    systemd.services.podman-homeassistant = {
      after = [myconfig.services.nfs.shares.config.mountUnit];
      requires = [myconfig.services.nfs.shares.config.mountUnit];
    };

    virtualisation.oci-containers.containers.homeassistant = {
      image = "lscr.io/linuxserver/homeassistant:2024.7.2";
      ports = ["8123:8123"];
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/homeassistant:/config"
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
