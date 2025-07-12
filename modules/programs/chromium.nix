{delib, ...}:
delib.module {
  # web browser
  name = "programs.chromium";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    programs = {
      # web browser, needs kernel keyring access for 1password integration
      chromium = {
        enable = true;
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        ];
      };
    };
  };
}
