{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "stylix";

  options = delib.singleEnableOption true;

  darwin.always.imports = [inputs.stylix.darwinModules.stylix];

  darwin.ifEnabled = {
    stylix = {
      enable = true;
      autoEnable = false;
    };
  };

  home.ifEnabled = {myconfig, ...}: {
    stylix.targets = {
      gnome.enable = myconfig.gtk.enable;
      kde.enable = myconfig.gtk.enable;
      kitty.enable = myconfig.programs.kitty.enable;
      mpv.enable = myconfig.programs.mpv.enable;
      rofi.enable = myconfig.programs.rofi.enable;
      starship.enable = myconfig.programs.starship.enable;
      swaylock.enable = myconfig.programs.swaylock.enable;
      waybar.enable = myconfig.programs.waybar.enable;
      zathura.enable = myconfig.programs.zathura.enable;
    };
  };

  nixos.always.imports = [inputs.stylix.nixosModules.stylix];

  nixos.ifEnabled = {
    stylix = {
      enable = true;
      autoEnable = false;
    };
  };
}
