{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.nfs";

  options.services.nfs = with delib; {
    enable = boolOption false;
    shares = listOfOption str [];
    serverHost = strOption "192.168.1.200";
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment.systemPackages = [
      pkgs.nfs-utils
    ];

    fileSystems = builtins.listToAttrs (
      map (share: {
        name = "/mnt/nfs/${share}";
        value = {
          device = "${cfg.serverHost}:/mnt/storage/${share}";
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
      cfg.shares
    );
  };
}

