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

    # read-only commands claude can run without asking
    programs.claude-code.settings.permissions = {
      allow = [
        "Bash(gh api repos/:*)"
        "Bash(gh api user --jq '.login')"
        "Bash(gh auth status)"
        "Bash(gh cache list:*)"
        "Bash(gh issue list:*)"
        "Bash(gh issue view:*)"
        "Bash(gh label list:*)"
        "Bash(gh pr checks:*)"
        "Bash(gh pr diff:*)"
        "Bash(gh pr list:*)"
        "Bash(gh pr view:*)"
        "Bash(gh release list:*)"
        "Bash(gh release view:*)"
        "Bash(gh repo view:*)"
        "Bash(gh run list:*)"
        "Bash(gh run view:*)"
        "Bash(gh search:*)"
        "Bash(gh workflow list:*)"
        "Bash(gh workflow view:*)"
      ];
      ask = [
        "Bash(gh pr edit:*)"
      ];
    };
  };
}
