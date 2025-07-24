{delib, ...}:
delib.module {
  name = "services.emby";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8096];

    # start after nfs mounts are available
    systemd.services.podman-emby = {
      after = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
      requires = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
    };

    virtualisation.oci-containers.containers.emby = {
      image = "lscr.io/linuxserver/emby:4.8.8.0-ls210";
      ports = ["8096:8096"];
      # TODO: use nfs config here
      volumes = [
        "/mnt/nfs/config/emby:/config"
        "/mnt/nfs/media:/data"
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

