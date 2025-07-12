{
  delib,
  homeconfig,
  ...
}:
delib.module {
  # nix cli helper
  name = "programs.nh";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.nh = {
      enable = true;
      # automatic garbage collection
      clean = {
        enable = true;
        extraArgs = "--keep 10 --keep-since 30d";
      };
    };

    home.sessionVariables.NH_FLAKE = "${homeconfig.home.homeDirectory}/Projects/personal/nix-config";
  };
}
