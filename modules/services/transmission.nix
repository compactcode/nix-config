{delib, ...}:
delib.module {
  name = "services.transmission";

  options = delib.singleEnableOption false;

  # dependencies
  myconfig.ifEnabled = {
    services = {
      gluetun = {
        enable = true;
        ports = [9091];
      };
      nfs.shares = {
        config.enable = true;
        media.enable = true;
      };
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # start after nfs mounts are available
    systemd.services.podman-transmission = {
      after = [
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
      requires = [
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.transmission = {
      dependsOn = [
        "gluetun"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
      };
      extraOptions = [
        "--network=container:gluetun"
      ];
      image = "lscr.io/linuxserver/transmission:4.0.6-r0-ls246";
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/transmission:/config"
        "${myconfig.services.nfs.shares.media.mountPath}:/data"
      ];
    };
  };
}
