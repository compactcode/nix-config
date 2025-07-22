{delib, ...}:
delib.module {
  # software development tools
  name = "features.development";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    editorconfig.enable = true;
    programs = {
      aider.enable = true;
      direnv.enable = true;
      gh.enable = true;
      nixvim.plugins = {
        aerial.enable = true;
        blink.enable = true;
        codecompanion.enable = true;
        conform.enable = true;
        gitlinker.enable = true;
        gitsigns.enable = true;
        grug-far.enable = true;
        lsp.enable = true;
        neotest.enable = true;
        other.enable = true;
        snacks.enable = true;
        yanky.enable = true;
      };
      opencode.enable = true;
    };
  };
}
