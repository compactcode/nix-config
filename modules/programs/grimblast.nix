{
  delib,
  pkgs,
  ...
}:
delib.module {
  # screenshot taker
  name = "programs.grimblast";

  options = {myconfig, ...}: {
    programs.grimblast = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
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
