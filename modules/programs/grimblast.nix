{
  delib,
  pkgs,
  ...
}:
delib.module {
  # screenshot taker
  name = "programs.grimblast";

  options = {
    programs.grimblast = with delib; {
      enable = boolOption false;
      editor = noDefault (strOption null);
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment = {
      sessionVariables = {
        GRIMBLAST_EDITOR = cfg.editor;
      };
      systemPackages = [pkgs.grimblast];
    };
  };
}
