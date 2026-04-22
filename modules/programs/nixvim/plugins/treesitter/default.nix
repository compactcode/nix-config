{
  delib,
  homeconfig,
  ...
}:
delib.module {
  # language parsing
  name = "programs.nixvim.plugins.treesitter";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with homeconfig.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          css
          dockerfile
          html
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
        # highlight embedded lua
        nixvimInjections = true;
        settings = {
          # replace default highlighting
          highlight.enable = true;
          # replace default indenting
          indent.enable = true;
        };
      };
    };
  };
}
