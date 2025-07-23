{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "stylix";

  options = delib.singleEnableOption false;

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
