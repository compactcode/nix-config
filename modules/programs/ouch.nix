{
  delib,
  pkgs,
  ...
}:
delib.module {
  # file compression/decompress
  name = "programs.ouch";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [pkgs.ouch];
  };
}
