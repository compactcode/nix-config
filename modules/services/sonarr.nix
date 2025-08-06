{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.sonarr";

  options.services.sonarr = with delib; {
    enable = boolOption false;
    serviceName = readOnly (strOption "podman-sonarr.service");
  };

  # dependencies
  myconfig.ifEnabled = {
    services = {
      gluetun = {
        enable = true;
        ports = [8989];
      };
      prowlarr.enable = true;
      transmission.enable = true;
      nfs.shares = {
        config.enable = true;
        media.enable = true;
      };
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # start after nfs mounts are available
    systemd.services.podman-sonarr = {
      after = [
        myconfig.services.gluetun.serviceName
        myconfig.services.prowlarr.serviceName
        myconfig.services.transmission.serviceName
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
      requires = [
        myconfig.services.gluetun.serviceName
        myconfig.services.prowlarr.serviceName
        myconfig.services.transmission.serviceName
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.sonarr = {
      environment = {
        TZ = myconfig.locale.timeZone;
        PUID = "1000";
        PGID = "1000";
      };
      extraOptions = [
        "--network=container:gluetun"
      ];
      image = "lscr.io/linuxserver/sonarr:4.0.8.1874-ls248";
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/sonarr:/config"
        "${myconfig.services.nfs.shares.media.mountPath}:/data"
      ];
    };
  };
}
