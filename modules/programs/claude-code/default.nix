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
            "Bash(awk:*)"
            "Bash(basename:*)"
            "Bash(bin/rspec:*)"
            "Bash(bundle check:*)"
            "Bash(bundle config:*)"
            "Bash(bundle env)"
            "Bash(bundle exec rspec:*)"
            "Bash(bundle exec rubocop:*)"
            "Bash(bundle exec standardrb:*)"
            "Bash(bundle info:*)"
            "Bash(bundle install:*)"
            "Bash(bundle list:*)"
            "Bash(bundle outdated:*)"
            "Bash(bundle platform:*)"
            "Bash(bundle show:*)"
            "Bash(cat:*)"
            "Bash(cmp:*)"
            "Bash(column:*)"
            "Bash(command -v:*)"
            "Bash(cut:*)"
            "Bash(date)"
            "Bash(diff:*)"
            "Bash(dirname:*)"
            "Bash(du:*)"
            "Bash(env)"
            "Bash(fd:*)"
            "Bash(file:*)"
            "Bash(find:*)"
            "Bash(gem env:*)"
            "Bash(gem list:*)"
            "Bash(gem which:*)"
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
            "Bash(git add:*)"
            "Bash(git blame:*)"
            "Bash(git branch:*)"
            "Bash(git cat-file:*)"
            "Bash(git checkout:*)"
            "Bash(git config get user.name:*)"
            "Bash(git config user.name:*)"
            "Bash(git describe:*)"
            "Bash(git diff:*)"
            "Bash(git fetch:*)"
            "Bash(git grep:*)"
            "Bash(git log:*)"
            "Bash(git ls-files:*)"
            "Bash(git ls-tree:*)"
            "Bash(git merge-base:*)"
            "Bash(git mv:*)"
            "Bash(git reflog:*)"
            "Bash(git remote -v)"
            "Bash(git remote show:*)"
            "Bash(git rev-parse:*)"
            "Bash(git shortlog:*)"
            "Bash(git show:*)"
            "Bash(git stash:*)"
            "Bash(git status:*)"
            "Bash(git tag --list:*)"
            "Bash(git whatchanged:*)"
            "Bash(git worktree list:*)"
            "Bash(grep:*)"
            "Bash(head:*)"
            "Bash(hostname)"
            "Bash(id)"
            "Bash(jq:*)"
            "Bash(ls:*)"
            "Bash(md5sum:*)"
            "Bash(mkdir:*)"
            "Bash(nix build:*)"
            "Bash(nix config show)"
            "Bash(nix derivation show:*)"
            "Bash(nix eval:*)"
            "Bash(nix flake:*)"
            "Bash(nix log:*)"
            "Bash(nix path-info:*)"
            "Bash(nix profile history)"
            "Bash(nix profile list)"
            "Bash(nix search:*)"
            "Bash(nix show-config)"
            "Bash(nix store:*)"
            "Bash(nix why-depends:*)"
            "Bash(nix-info:*)"
            "Bash(nix-store --query:*)"
            "Bash(nixos-rebuild dry-build:*)"
            "Bash(pwd)"
            "Bash(readlink:*)"
            "Bash(realpath:*)"
            "Bash(rg:*)"
            "Bash(rspec:*)"
            "Bash(ruby --version)"
            "Bash(ruby -v)"
            "Bash(sha256sum:*)"
            "Bash(shasum:*)"
            "Bash(sort:*)"
            "Bash(stat:*)"
            "Bash(sw_vers)"
            "Bash(tail:*)"
            "Bash(test:*)"
            "Bash(tr:*)"
            "Bash(tree:*)"
            "Bash(type:*)"
            "Bash(uname:*)"
            "Bash(uniq:*)"
            "Bash(wc:*)"
            "Bash(which:*)"
            "Bash(whoami)"
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
