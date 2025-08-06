{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.prowlarr";

  options.services.prowlarr = with delib; {
    enable = boolOption false;
    serviceName = readOnly (strOption "podman-prowlarr.service");
  };

  # dependencies
  myconfig.ifEnabled = {
    services = {
      gluetun = {
        enable = true;
        ports = [9696];
      };
      nfs.shares.config.enable = true;
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # ensure container starts after nfs mount
    systemd.services.podman-prowlarr = {
      after = [
        myconfig.services.gluetun.serviceName
        myconfig.services.nfs.shares.config.mountUnit
      ];
      requires = [
        myconfig.services.gluetun.serviceName
        myconfig.services.nfs.shares.config.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.prowlarr = {
      environment = {
        PUID = "1000";
        PGID = "1000";
      };
      extraOptions = [
        "--network=container:gluetun"
      ];
      image = "lscr.io/linuxserver/prowlarr:1.20.1.4603-ls78";
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/prowlarr:/config"
      ];
    };
  };
}
