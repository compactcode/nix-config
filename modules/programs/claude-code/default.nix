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
            "Bash(bundle exec rubocop:*)"
            "Bash(bundle list:*)"
            "Bash(bundle show:*)"
            "Bash(fd:*)"
            "Bash(find:*)"
            "Bash(gh pr checks:*)"
            "Bash(gh pr diff:*)"
            "Bash(gh pr list:*)"
            "Bash(gh pr view:*)"
            "Bash(git config get user.name:*)"
            "Bash(git config user.name:*)"
            "Bash(git diff:*)"
            "Bash(git log:*)"
            "Bash(git mv:*)"
            "Bash(git rev-parse:*)"
            "Bash(git show:*)"
            "Bash(git status:*)"
            "Bash(grep:*)"
            "Bash(ls:*)"
            "Bash(mkdir:*)"
            "Bash(rg:*)"
            "Bash(rspec:*)"
            "Bash(test:*)"
            "Read(*)"
            "WebFetch(domain:code.claude.com)"
            "WebFetch(domain:www.home-assistant.io)"
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
