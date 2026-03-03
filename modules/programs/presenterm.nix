{
  delib,
  pkgs,
  ...
}:
delib.module {
  # cli presentations
  name = "programs.presenterm";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.presenterm];
  };
}
