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
      bat.enable = myconfig.programs.bat.enable;
      btop.enable = myconfig.programs.btop.enable;
      gnome.enable = myconfig.gtk.enable;
      kde.enable = myconfig.gtk.enable;
      kitty.enable = myconfig.programs.kitty.enable;
      lazygit.enable = myconfig.programs.lazygit.enable;
      mpv.enable = myconfig.programs.mpv.enable;
      rofi.enable = myconfig.programs.rofi.enable;
      starship.enable = myconfig.programs.starship.enable;
      swaylock.enable = myconfig.programs.swaylock.enable;
      waybar.enable = myconfig.programs.waybar.enable;
      yazi.enable = myconfig.programs.yazi.enable;
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
