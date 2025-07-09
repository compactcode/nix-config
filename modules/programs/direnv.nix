{delib, ...}:
delib.module {
  # environment loading
  name = "progams.direnv";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      # faster nix handling
      nix-direnv.enable = true;
    };
  };
}
