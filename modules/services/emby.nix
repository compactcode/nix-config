{delib, ...}:
delib.module {
  name = "services.emby";

  options = delib.singleEnableOption false;

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
      image = "lscr.io/linuxserver/emby:4.9.1.90-ls260";
      ports = ["8096:8096"];
      volumes = [
        "${myconfig.services.nfs.shares.config.mountPath}/emby:/config"
        "${myconfig.services.nfs.shares.media.mountPath}:/data"
      ];
      environment = {
        PUID = myconfig.services.nfs.puid;
        PGID = myconfig.services.nfs.pgid;
        TZ = myconfig.locale.timeZone;
      };
      devices = [
        "/dev/dri:/dev/dri" # pass through hardware acceleration
      ];
    };
  };
}
