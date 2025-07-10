{
  delib,
  pkgs,
  ...
}:
delib.module {
  # api explorer
  name = "programs.bruno";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [pkgs.bruno];
  };
}
