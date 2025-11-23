{delib, ...}:
delib.module {
  name = "services.homeassistant";

  options = delib.singleEnableOption false;

  # dependencies
  myconfig.ifEnabled = {
    services.nfs.shares.config.enable = true;
  };

  nixos.ifEnabled = {config, myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8123];

    # ensure container starts after nfs mount
    systemd.services."${config.virtualisation.oci-containers.backend}-homeassistant" = {
      after = [
        myconfig.services.nfs.shares.config.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.homeassistant = {
      image = "lscr.io/linuxserver/homeassistant:2025.11.2";
      ports = ["8123:8123"];
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/homeassistant:/config"
      ];
      environment = {
        PUID = myconfig.services.nfs.puid;
        PGID = myconfig.services.nfs.pgid;
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        # allow device discovery on the host network
        "--network=host"
      ];
    };
  };
}
