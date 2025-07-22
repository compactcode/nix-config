{delib, ...}:
delib.module {
  # web browser
  name = "programs.chromium";

  options = delib.singleEnableOption false;

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
