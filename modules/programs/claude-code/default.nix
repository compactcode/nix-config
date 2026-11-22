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

      plugins.superpowers = inputs.superpowers;

      settings = {
        effortLevel = "high";
        # enable claude in chrome browser tools by default
        env.CLAUDE_CODE_ENABLE_CFC = "1";
        modelSettings."claude-opus-5-5".effortLevel = "high";
        includeCoAuthoredBy = false;
        outputStyle = "Concise";
        tui = "fullscreen";
        hooks.SessionStart = [
          {
            matcher = "startup|clear|compact";
            hooks = [
              {
                type = "command";
                command = ''"${inputs.superpowers}/hooks/run-hook.cmd" session-start'';
                async = false;
              }
            ];
          }
        ];
        permissions = {
          allow = [
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
            "Bash(file:*)"
            "Bash(find:*)"
            "Bash(gem env:*)"
            "Bash(gem list:*)"
            "Bash(gem which:*)"
            "Bash(grep:*)"
            "Bash(head:*)"
            "Bash(hostname)"
            "Bash(id)"
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
            "Read"
            "WebFetch(domain:code.claude.com)"
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
          defaultMode = "auto";
        };
      };
    };
  };
}
