{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.emby";

  options.services.emby = with delib; {
    enable = boolOption false;
    serviceName = readOnly (strOption "podman-emby.service");
  };

  # dependencies
  myconfig.ifEnabled = {
    services.nfs.shares = {
      config.enable = true;
      media.enable = true;
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8096];

    # start after nfs mounts are available
    systemd.services.podman-emby = {
      after = [
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
      requires = [
        myconfig.services.nfs.shares.config.mountUnit
        myconfig.services.nfs.shares.media.mountUnit
      ];
    };

    virtualisation.oci-containers.containers.emby = {
      image = "lscr.io/linuxserver/emby:4.8.8.0-ls210";
      ports = ["8096:8096"];
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/emby:/config"
        "${myconfig.services.nfs.shares.media.mountPath}:/data"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        # pass through hardware acceleration
        "--device=/dev/dri:/dev/dri"
      ];
    };
  };
}
