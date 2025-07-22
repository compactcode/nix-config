{
  delib,
  pkgs,
  ...
}:
delib.module {
  # messenger
  name = "programs.signal";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.signal-desktop];
  };
}
