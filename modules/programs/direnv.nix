{delib, ...}:
delib.module {
  # environment loading
  name = "programs.direnv";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      # faster nix handling
      nix-direnv.enable = true;
    };
  };
}
