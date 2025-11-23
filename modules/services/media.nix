{delib, ...}:
delib.module {
  name = "services.media";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {config, myconfig, ...}: {
    networking.firewall.allowedTCPPorts = [
      7878
      8096
      8989
      9091
      9696
    ];

    # ensure containers start after nfs mount
    systemd.services = {
      "${config.virtualisation.oci-containers.backend}-gluetun" = {
        after = [
          myconfig.services.nfs.shares.config.mountUnit
        ];
      };
      "${config.virtualisation.oci-containers.backend}-prowlarr" = {
        after = [
          myconfig.services.nfs.shares.config.mountUnit
        ];
      };
      "${config.virtualisation.oci-containers.backend}-radarr" = {
        after = [
          myconfig.services.nfs.shares.config.mountUnit
          myconfig.services.nfs.shares.media.mountUnit
        ];
      };
      "${config.virtualisation.oci-containers.backend}-sonarr" = {
        after = [
          myconfig.services.nfs.shares.config.mountUnit
          myconfig.services.nfs.shares.media.mountUnit
        ];
      };
      "${config.virtualisation.oci-containers.backend}-transmission" = {
        after = [
          myconfig.services.nfs.shares.config.mountUnit
          myconfig.services.nfs.shares.media.mountUnit
        ];
      };
    };

    virtualisation.oci-containers.containers = {
      gluetun = {
        autoStart = true;
        capabilities = {
          NET_ADMIN = true; # allow network creation
        };
        devices = [
          "/dev/net/tun:/dev/net/tun"
        ];
        environmentFiles = [
          "${myconfig.services.nfs.shares.config.mountPath}/gluetun/secret.env"
        ];
        environment = {
          PUID = myconfig.services.nfs.puid;
          PGID = myconfig.services.nfs.pgid;
          TZ = myconfig.locale.timeZone;
        };
        image = "ghcr.io/qdm12/gluetun:v3.40.3";
        ports = [
          "7878:7878" # radarr
          "8989:8989" # sonarr
          "9091:9091" # transmission
          "9696:9696" # prowlarr
        ];
      };

      prowlarr = {
        autoStart = true;
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = myconfig.services.nfs.puid;
          PGID = myconfig.services.nfs.pgid;
          TZ = myconfig.locale.timeZone;
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/prowlarr:2.3.0.5236-ls132";
        volumes = [
          "${myconfig.services.nfs.shares.config.mountPath}/prowlarr:/config"
        ];
      };

      radarr = {
        autoStart = true;
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
        environment = {
          PUID = myconfig.services.nfs.puid;
          PGID = myconfig.services.nfs.pgid;
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

      sonarr = {
        autoStart = true;
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
        environment = {
          TZ = myconfig.locale.timeZone;
          PUID = myconfig.services.nfs.puid;
          PGID = myconfig.services.nfs.pgid;
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/sonarr:4.0.16.2944-ls297";
        volumes = [
          "${myconfig.services.nfs.shares.config.mountPath}/sonarr:/config"
          "${myconfig.services.nfs.shares.media.mountPath}:/data"
        ];
      };

      transmission = {
        autoStart = true;
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = myconfig.services.nfs.puid;
          PGID = myconfig.services.nfs.pgid;
          TZ = myconfig.locale.timeZone;
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/transmission:4.0.6-r4-ls319";
        volumes = [
          "${myconfig.services.nfs.shares.config.mountPath}/transmission:/config"
          "${myconfig.services.nfs.shares.media.mountPath}:/data"
        ];
      };
    };
  };
}
