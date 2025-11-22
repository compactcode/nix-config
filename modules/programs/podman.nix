{
  delib,
  pkgs,
  ...
}:
delib.module {
  # container manager
  name = "programs.podman";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      podman
    ];
  };

  nixos.ifEnabled = {
    virtualisation = {
      podman = {
        enable = true;
        # remove unused containers
        autoPrune.enable = true;
        # replace the docker socket
        dockerSocket.enable = true;
        # replace the docker command
        dockerCompat = true;
      };

      # use for running oci-containers
      oci-containers.backend = "podman";
    };
  };
}
