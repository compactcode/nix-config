{delib, ...}:
delib.module {
  # github cli
  name = "programs.gh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.shellAliases = {
      # open current pr in a browser
      ghp = "gh pr view --web";
      # view checks for current pr
      ghc = "gh pr checks";
    };

    programs.gh.enable = true;
  };
}
