{delib, ...}:
delib.module {
  name = "home-manager";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    home-manager = {
      # pass configured pkgs from system to home-manager
      useGlobalPkgs = true;
      # enable home.packages
      useUserPackages = true;
    };
  };

  nixos.ifEnabled = {
    home-manager = {
      # pass configured pkgs from system to home-manager
      useGlobalPkgs = true;
      # enable home.packages
      useUserPackages = true;
    };
  };
}
