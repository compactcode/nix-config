{delib, ...}:
delib.module {
  name = "services.sonarr";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [8989];

    # start after nfs mounts are available
    systemd.services.podman-sonarr = {
      after = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
      requires = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
    };

    virtualisation.oci-containers.containers.sonarr = {
      image = "lscr.io/linuxserver/sonarr:4.0.8.1874-ls248";
      ports = ["8989:8989"];
      volumes = [
        "/mnt/nfs/config/sonarr:/config"
        "/mnt/nfs/media:/data"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = myconfig.locale.timeZone;
      };
    };
  };
}
