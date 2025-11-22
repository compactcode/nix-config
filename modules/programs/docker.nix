{delib, ...}:
delib.module {
  # container manager
  name = "programs.docker";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    users.${myconfig.users.primary.id}.extraGroups = [
      "docker" # allow docker control
    ];

    virtualisation = {
      docker = {
        enable = true;
        # remove unused containers
        autoPrune.enable = true;
      };

      # use for running oci-containers
      oci-containers.backend = "docker";
    };
  };
}
