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
      # TODO e=EACCES: permission denied, open '/home/shandogs/.config/opencode/config.json'
      # settings = {
      #   # avoid exposing sensitive information
      #   autoshare = false;
      #   # disable due to being installed via nix
      #   autoupdate = false;
      # };
    };
  };
}
