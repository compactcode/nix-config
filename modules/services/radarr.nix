{delib, ...}:
delib.module {
  name = "services.radarr";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # open firewall
    networking.firewall.allowedTCPPorts = [7878];

    # start after nfs mounts are available
    systemd.services.podman-radarr = {
      after = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
      requires = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
    };

    virtualisation.oci-containers.containers.radarr = {
      image = "lscr.io/linuxserver/radarr:5.7.0.8882-ls229";
      ports = ["7878:7878"];
      volumes = [
        "/mnt/nfs/config/radarr:/config"
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
