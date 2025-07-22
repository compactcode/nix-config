{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nixvim.plugins.treesitter";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    # language parsing
    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          css
          dockerfile
          html
          json
          lua
          make
          markdown
          nix
          python
          query
          regex
          ruby
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
