{
  delib,
  pkgs,
  ...
}:
delib.module {
  # image editor
  name = "programs.pinta";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.pinta];
  };
}
