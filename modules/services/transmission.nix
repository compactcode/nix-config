{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.transmission";

  options.services.transmission = with delib; {
    enable = boolOption false;
    serviceName = readOnly (strOption "podman-transmission.service");
  };

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
        myconfig.services.gluetun.serviceName
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
      requires = [
        myconfig.services.gluetun.serviceName
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.transmission = {
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
