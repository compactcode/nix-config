{delib, ...}:
delib.module {
  # environment loading
  name = "programs.direnv";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      # hide .direnv cache from git
      enableGitIntegration = true;
    };
  };
}
