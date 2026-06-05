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

      # stylix/nix-darwin release markers drift (26.11 vs 26.05); same nixpkgs
      enableReleaseChecks = false;
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

      # stylix/nixos release markers drift; same nixpkgs
      enableReleaseChecks = false;
    };
  };
}
