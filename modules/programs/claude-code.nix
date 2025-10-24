{delib, ...}:
delib.module {
  # ai assistant
  name = "programs.claude-code";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.claude-code = {
      enable = true;

      # TODO: Pollutes the main context: https://github.com/anthropics/claude-code/issues/6915
      # mcpServers = {
      #   playwright = {
      #     type = "stdio";
      #     command = "${pkgs.playwright-mcp}/bin/mcp-server-playwright";
      #     args = [];
      #     env = {};
      #   };
      # };

      settings = {
        permissions = {
          allow = [
            "Bash(bundle exec rspec:*)"
            "Bash(find:*)"
            "Bash(gh pr view:*)"
            "Bash(git diff:*)"
            "Bash(git status:*)"
            "Bash(ls:*)"
            "Bash(rg:*)"
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
