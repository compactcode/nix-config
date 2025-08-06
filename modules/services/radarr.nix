{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.radarr";

  options.services.radarr = with delib; {
    enable = boolOption false;
    serviceName = readOnly (strOption "podman-radarr.service");
  };

  # dependencies
  myconfig.ifEnabled = {
    services = {
      gluetun = {
        enable = true;
        ports = [7878];
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
    systemd.services.podman-radarr = {
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

    virtualisation.oci-containers.containers.radarr = {
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        "--network=container:gluetun"
      ];
      image = "lscr.io/linuxserver/radarr:5.7.0.8882-ls229";
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/radarr:/config"
        "${myconfig.services.nfs.shares.media.mountPath}:/data"
      ];
    };
  };
}
