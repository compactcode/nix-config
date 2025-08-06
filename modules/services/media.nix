{delib, ...}:
delib.module {
  name = "services.media";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    networking.firewall.allowedTCPPorts = [
      7878
      8096
      8989
      9091
      9696
    ];

    # ensure containers start after nfs mount
    systemd.services = {
      podman-gluetun = {
        after = ["mnt-nas-config.mount"];
        requires = ["mnt-nas-config.mount"];
      };
      podman-prowlarr = {
        after = ["mnt-nas-config.mount"];
        requires = ["mnt-nas-config.mount"];
      };
      podman-radarr = {
        after = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
        requires = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
      };
      podman-sonarr = {
        after = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
        requires = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
      };
      podman-transmission = {
        after = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
        requires = ["mnt-nas-config.mount" "mnt-nas-media.mount"];
      };
    };

    virtualisation.oci-containers.containers = {
      gluetun = {
        # allow network creation
        devices = [
          "/dev/net/tun:/dev/net/tun"
        ];
        environmentFiles = [
          "/mnt/nas/config/gluetun/secret.env" # not managed by nix
        ];
        environment = {
          SERVER_COUNTRIES = "Australia";
        };
        # allow network creation
        extraOptions = [
          "--cap-add=NET_ADMIN"
        ];
        image = "ghcr.io/qdm12/gluetun:v3.38.0";
        ports = [
          "7878:7878" # radarr
          "8989:8989" # sonarr
          "9091:9091" # transmission
          "9696:9696" # prowlarr
        ];
      };

      prowlarr = {
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/prowlarr:1.20.1.4603-ls78";
        volumes = [
          "/mnt/nas/config/prowlarr:/config"
        ];
      };

      radarr = {
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
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
          "/mnt/nas/config/radarr:/config"
          "/mnt/nas/media:/data"
        ];
      };

      sonarr = {
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
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
          "/mnt/nas/config/sonarr:/config"
          "/mnt/nas/media:/data"
        ];
      };

      transmission = {
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/transmission:4.0.6-r0-ls246";
        volumes = [
          "/mnt/nas/config/transmission:/config"
          "/mnt/nas/media:/data"
        ];
      };
    };
  };
}
