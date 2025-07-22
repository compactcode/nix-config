{
  delib,
  pkgs,
  ...
}:
delib.module {
  # messenger
  name = "programs.slack";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.slack];
  };
}
