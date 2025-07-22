{
  delib,
  pkgs,
  ...
}:
delib.module {
  # api explorer
  name = "programs.bruno";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.bruno];
  };
}
