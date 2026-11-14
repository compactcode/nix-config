{
  delib,
  homeconfig,
  ...
}:
delib.module {
  # language parsing
  name = "programs.nixvim.plugins.treesitter.development";

  options = delib.singleEnableOption false;

  home.ifEnabled.programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with homeconfig.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        go
        python
        query
        ruby
        rust
        scss
        slim
        sql
        tsx
        typescript
      ];
    };

    # language query extensions (used by mini.ai)
    treesitter-textobjects.enable = true;
  };
}
