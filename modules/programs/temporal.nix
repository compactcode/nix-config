{
  delib,
  pkgs,
  ...
}:
delib.module {
  # temporal workflow cli
  name = "programs.temporal";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.temporal-cli];
  };
}
