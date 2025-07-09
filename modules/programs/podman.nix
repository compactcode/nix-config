{
  delib,
  pkgs,
  ...
}:
delib.module {
  # container manager
  name = "programs.podman";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      podman
    ];
  };

  nixos.ifEnabled = {
    virtualisation = {
      podman = {
        enable = true;
        # replace the docker socket
        dockerSocket.enable = true;
        # replace the docker command
        dockerCompat.enable = true;
      };
    };
  };
}
