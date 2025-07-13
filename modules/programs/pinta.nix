{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  # image editor
  name = "programs.pinta";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {...}: {
    myconfig.programs.grimblast.editor = "${lib.getExe pkgs.pinta}";

    environment.systemPackages = [pkgs.pinta];
  };
}
