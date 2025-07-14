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
      enable = boolOption pkgs.stdenv.isDarwin;
    };
  };

  home.ifEnabled = {
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
