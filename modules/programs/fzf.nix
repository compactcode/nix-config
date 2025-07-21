{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fzf";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.shellAliases = {
      f = "fzf";
    };

    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
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

    # automatic styling
    stylix.targets.fzf.enable = true;
  };
}
