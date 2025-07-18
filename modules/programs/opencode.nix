{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.opencode";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    # more frequent releases than nixpkgs
    homebrew.brews = ["sst/tap/opencode"];
  };

  home.ifEnabled = {
    programs.opencode = lib.mkIf pkgs.stdenv.isLinux {
      enable = true;
      settings = {
        # avoid exposing sensitive information
        autoshare = false;
        # disable due to being installed via nix
        autoupdate = false;
      };
    };
  };
}
