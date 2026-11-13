{
  delib,
  pkgs,
  ...
}:
delib.module {
  # web browser
  name = "programs.chromium";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "chromium"
      ];
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.chromium];

    programs = {
      chromium = {
        enable = true;
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
          "fcoeoabgfenejglbffodgkkbkcdhcgfn" # claude in chrome
        ];
      };
    };

    stylix.targets.chromium.enable = true;
  };
}
