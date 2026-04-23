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
    home = {
      packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code-acp # remote control
      ];
      shellAliases.cl = "claude";
    };

    programs.claude-code = {
      enable = true;

      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;

      marketplaces = {
        superpowers-marketplace = inputs.superpowers-marketplace;
      };

      settings = {
        includeCoAuthoredBy = false;
        enabledPlugins = {
          "superpowers@superpowers-marketplace" = true;
        };
        permissions = {
          allow = [
            "Bash(agent-browser click:*)"
            "Bash(agent-browser fill:*)"
            "Bash(agent-browser get:*)"
            "Bash(agent-browser network:*)"
            "Bash(agent-browser open:*)"
            "Bash(agent-browser reload:*)"
            "Bash(agent-browser screenshot:*)"
            "Bash(agent-browser scroll:*)"
            "Bash(agent-browser skills:*)"
            "Bash(agent-browser snapshot:*)"
            "Bash(agent-browser wait:*)"
            "Bash(bin/rspec:*)"
            "Bash(bundle check:*)"
            "Bash(bundle exec rspec:*)"
            "Bash(bundle exec rubocop:*)"
            "Bash(bundle exec standardrb:*)"
            "Bash(bundle info:*)"
            "Bash(bundle install:*)"
            "Bash(bundle list:*)"
            "Bash(bundle show:*)"
            "Bash(cat:*)"
            "Bash(fd:*)"
            "Bash(find:*)"
            "Bash(gh api user --jq '.login')"
            "Bash(gh pr checks:*)"
            "Bash(gh pr diff:*)"
            "Bash(gh pr list:*)"
            "Bash(gh pr view:*)"
            "Bash(gh repo view:*)"
            "Bash(gh run list:*)"
            "Bash(gh run view:*)"
            "Bash(git add:*)"
            "Bash(git branch:*)"
            "Bash(git cat-file:*)"
            "Bash(git checkout:*)"
            "Bash(git config get user.name:*)"
            "Bash(git config user.name:*)"
            "Bash(git diff:*)"
            "Bash(git fetch:*)"
            "Bash(git log:*)"
            "Bash(git merge-base:*)"
            "Bash(git mv:*)"
            "Bash(git rev-parse:*)"
            "Bash(git show:*)"
            "Bash(git status:*)"
            "Bash(git stash:*)"
            "Bash(grep:*)"
            "Bash(head:*)"
            "Bash(jq:*)"
            "Bash(ls:*)"
            "Bash(mkdir:*)"
            "Bash(nix build:*)"
            "Bash(nix eval:*)"
            "Bash(nix flake:*)"
            "Bash(nix profile history)"
            "Bash(nix profile list)"
            "Bash(nix store:*)"
            "Bash(readlink:*)"
            "Bash(rg:*)"
            "Bash(rspec:*)"
            "Bash(sort:*)"
            "Bash(stat:*)"
            "Bash(tail:*)"
            "Bash(test:*)"
            "Read(*)"
            "Skill(agent-browser)"
            "WebFetch(domain:code.claude.com)"
            "WebFetch(domain:devenv.sh)"
            "WebFetch(domain:docs.claude.com)"
            "WebFetch(domain:docs.zeptopayments.com)"
            "WebFetch(domain:dry-rb.org)"
            "WebFetch(domain:github.com)"
            "WebFetch(domain:raw.githubusercontent.com)"
            "WebFetch(domain:rubydoc.info)"
            "WebFetch(domain:rubygems.org)"
            "WebFetch(domain:www.anthropic.com)"
            "WebFetch(domain:www.home-assistant.io)"
            "WebSearch"
          ];
          ask = [
            "Bash(gh pr edit:*)"
            "Bash(git push:*)"
            "Bash(git rebase:*)"
          ];
          defaultMode = "plan";
        };
      };
    };
  };
}
