{delib, ...}:
delib.module {
  # environment loading
  name = "programs.cli.direnv";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      # faster nix handling
      nix-direnv.enable = true;
    };
  };
}
