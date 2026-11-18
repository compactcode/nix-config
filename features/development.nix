{delib, ...}:
delib.module {
  # software development tools
  name = "features.development";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    editorconfig.enable = true;
    programs = {
      agent-skills.enable = true;
      devenv.enable = true;
      direnv.enable = true;
      gh.enable = true;
      herdr.enable = true;
      jujutsu.enable = true;
      nixvim.plugins = {
        blink.enable = true;
        gitlinker.enable = true;
        gitsigns.enable = true;
        lsp.enable = true;
        snacks.enable = true;
        treesitter.development.enable = true;
        yanky.enable = true;
      };
      # opencode.enable = true;
      presenterm.enable = true;
      # temporal.enable = true;
    };
  };
}
