{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.claude-code";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.playwright-test];

    home.file.".claude/skills/joke/SKILL.md".source = ./skills/joke/SKILL.md;

    programs.claude-code = {
      enable = true;

      settings = {
        permissions = {
          allow = [
            "Bash(bundle exec rspec:*)"
            "Bash(fd:*)"
            "Bash(find:*)"
            "Bash(gh pr view:*)"
            "Bash(git diff:*)"
            "Bash(git log:*)"
            "Bash(git mv:*)"
            "Bash(git show:*)"
            "Bash(git status:*)"
            "Bash(grep:*)"
            "Bash(ls:*)"
            "Bash(mkdir:*)"
            "Bash(rg:*)"
            "Bash(test:*)"
            "Read(*)"
          ];
          ask = [
            "Bash(git push:*)"
          ];
          defaultMode = "plan";
        };
      };
    };
  };
}
