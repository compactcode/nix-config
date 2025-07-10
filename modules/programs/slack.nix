{
  delib,
  pkgs,
  ...
}:
delib.module {
  # messenger
  name = "programs.slack";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [pkgs.slack];
  };
}
