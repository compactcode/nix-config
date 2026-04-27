{delib, ...}:
delib.module {
  # software development tools
  name = "features.development";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    editorconfig.enable = true;
    programs = {
      agent-browser.enable = true;
      agent-skills.enable = true;
      claude-code.enable = true;
      devenv.enable = true;
      direnv.enable = true;
      # gemini-cli.enable = true;
      gh.enable = true;
      handy.enable = true;
      jujutsu.enable = true;
      nixvim.plugins = {
        aerial.enable = true;
        blink.enable = true;
        conform.enable = true;
        gitlinker.enable = true;
        gitsigns.enable = true;
        # grug-far.enable = true; # temporarily disabled - ast-grep build failure
        lsp.enable = true;
        neotest.enable = true;
        other.enable = true;
        snacks.enable = true;
        treesitter.development.enable = true;
        yanky.enable = true;
      };
      # opencode.enable = true;
      presenterm.enable = true;
    };
  };
}
