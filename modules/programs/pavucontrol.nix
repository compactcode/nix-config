{
  delib,
  pkgs,
  ...
}:
delib.module {
  # sound manager
  name = "programs.pavucontrol";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.pavucontrol];
  };
}
