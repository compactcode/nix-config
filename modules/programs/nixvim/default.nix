{
  delib,
  inputs,
  ...
}:
delib.module {
  # code editor
  name = "programs.nixvim";

  options = delib.singleEnableOption true;

  home.always.imports = [inputs.nixvim.homeManagerModules.nixvim];

  home.ifEnabled = {
    programs.nixvim = {
      enable = true;

      plugins = {
        # lazy loading
        lz-n.enable = true;
      };

      withNodeJs = false;
      withPerl = false;
      withRuby = false;
    };
  };
}
