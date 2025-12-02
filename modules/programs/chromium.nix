{delib, ...}:
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
    programs = {
      chromium = {
        enable = true;
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        ];
      };
    };

    stylix.targets.chromium.enable = true;
  };
}
