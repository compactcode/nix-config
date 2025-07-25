{delib, ...}:
delib.module {
  name = "services.prowlarr";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    # start after nfs mounts and gluetun are available
    systemd.services.podman-prowlarr = {
      after = ["mnt-nfs-config.mount" "podman-gluetun.service"];
      requires = ["mnt-nfs-config.mount" "podman-gluetun.service"];
    };

    virtualisation.oci-containers.containers.prowlarr = {
      image = "lscr.io/linuxserver/prowlarr:1.20.1.4603-ls78";
      volumes = [
        "/mnt/nfs/config/prowlarr:/config"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = myconfig.locale.timeZone;
      };
      extraOptions = [
        "--network=container:gluetun"
      ];
    };
  };
}
