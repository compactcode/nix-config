{
  delib,
  pkgs,
  ...
}:
delib.module {
  # web browser
  name = "programs.chromium";

  options = {
    programs.chromium = with delib; {
      enable = boolOption pkgs.stdenv.isLinux;
    };
  };

  home.ifEnabled = {
    programs = {
      chromium = {
        enable = true;
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        ];
      };
    };
  };

  nixos.ifEnabled = {
    stylix.targets.chromium.enable = true;
  };
}
