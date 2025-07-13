{
  delib,
  pkgs,
  ...
}:
delib.module {
  # sound manager
  name = "programs.pavucontrol";

  options = {myconfig, ...}: {
    programs.pavucontrol = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.pavucontrol];
  };
}
