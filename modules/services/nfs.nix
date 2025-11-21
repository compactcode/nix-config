{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.nfs";

  options.services.nfs = with delib; {
    enable = boolOption false;
    shares = {
      config = {
        enable = boolOption false;
        mountUnit = readOnly (strOption "mnt-nfs-config.mount");
        mountPath = readOnly (strOption "/mnt/nfs/config");
        remotePath = readOnly (strOption "/mnt/storage/config");
      };
      documents = {
        enable = boolOption false;
        mountUnit = readOnly (strOption "mnt-nfs-documents.mount");
        mountPath = readOnly (strOption "/mnt/nfs/documents");
        remotePath = readOnly (strOption "/mnt/storage/documents");
      };
      media = {
        enable = boolOption false;
        mountUnit = readOnly (strOption "mnt-nfs-media.mount");
        mountPath = readOnly (strOption "/mnt/nfs/media");
        remotePath = readOnly (strOption "/mnt/storage/media");
      };
      photos = {
        enable = boolOption false;
        mountUnit = readOnly (strOption "mnt-nfs-photo.mount");
        mountPath = readOnly (strOption "/mnt/nfs/photos");
        remotePath = readOnly (strOption "/mnt/storage/photos");
      };
    };
    serverHost = strOption "192.168.1.200";
    puid = strOption "568"; # app user
    pgid = strOption "568"; # app group
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment.systemPackages = [
      pkgs.nfs-utils
    ];

    fileSystems = let
      enabledShares = builtins.filter (s: s.enable) (builtins.attrValues cfg.shares);
    in
      builtins.listToAttrs (
        map (share: {
          name = share.mountPath;
          value = {
            device = "${cfg.serverHost}:${share.remotePath}";
            fsType = "nfs";
            options = [
              # connect on-demand
              "x-systemd.automount"
              # not at boot
              "noauto"
              # disconnect when no longer in use
              "x-systemd.idle-timeout=600"
            ];
          };
        })
        enabledShares
      );
  };
}
