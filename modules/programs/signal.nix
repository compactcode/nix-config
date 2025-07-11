{
  delib,
  pkgs,
  ...
}:
delib.module {
  # messenger
  name = "programs.signal";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.signal-desktop];
  };
}
