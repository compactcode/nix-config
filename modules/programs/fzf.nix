{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "progams.fzf";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs = {
      fzf = {
        enable = true;
        # use fd for listing files
        defaultCommand = "${lib.getExe pkgs.fd} --type f";
        defaultOptions = [
          # search bar at the top
          "--reverse"
          # display results inline instead of fullscreen
          "--height 40%"
        ];
      };
    };

    home.shellAliases = {
      f = "fzf";
    };
  };
}
