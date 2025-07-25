{delib, ...}:
delib.module {
  # environment loading
  name = "programs.direnv";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        # faster nix handling
        nix-direnv.enable = true;
      };

      # hide cache from git
      git.ignores = [
        ".direnv"
      ];
    };
  };
}
