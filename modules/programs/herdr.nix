{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # terminal-native agent multiplexer
  name = "programs.herdr";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
