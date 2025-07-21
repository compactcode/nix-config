{
  delib,
  pkgs,
  ...
}:
delib.module {
  # file compression/decompress
  name = "programs.ouch";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.ouch];
  };
}
