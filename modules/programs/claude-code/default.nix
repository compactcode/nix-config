{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.claude-code";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.file.".claude/skills/joke/SKILL.md".source = ./skills/joke/SKILL.md;

    programs.claude-code = {
      enable = true;

      package = inputs.nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;

      settings = {
        permissions = {
          allow = [
            "Bash(bundle exec rspec:*)"
            "Bash(bundle exec rubocop:*)"
            "Bash(bundle list:*)"
            "Bash(bundle show:*)"
            "Bash(cat:*)"
            "Bash(jq:*)"
            "Bash(stat:*)"
            "Bash(fd:*)"
            "Bash(find:*)"
            "Bash(gh pr checks:*)"
            "Bash(gh pr diff:*)"
            "Bash(gh pr list:*)"
            "Bash(gh pr view:*)"
            "Bash(gh run list:*)"
            "Bash(gh run view:*)"
            "Bash(git config get user.name:*)"
            "Bash(git config user.name:*)"
            "Bash(git diff:*)"
            "Bash(git log:*)"
            "Bash(git mv:*)"
            "Bash(git rev-parse:*)"
            "Bash(git show:*)"
            "Bash(git status:*)"
            "Bash(grep:*)"
            "Bash(head:*)"
            "Bash(ls:*)"
            "Bash(mkdir:*)"
            "Bash(rg:*)"
            "Bash(rspec:*)"
            "Bash(sort:*)"
            "Bash(tail:*)"
            "Bash(test:*)"
            "Read(*)"
            "WebFetch(domain:code.claude.com)"
            "WebFetch(domain:github.com)"
            "WebFetch(domain:www.anthropic.com)"
            "WebFetch(domain:www.home-assistant.io)"
            "WebSearch"
          ];
          ask = [
            "Bash(git push:*)"
          ];
          defaultMode = "plan";
        };

        mcpServers = {
          playwright = {
            command = "${pkgs.playwright-mcp}/bin/mcp-server-playwright";
            type = "stdio";
          };
        };
      };
    };
  };
}
