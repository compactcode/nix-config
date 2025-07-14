{delib, ...}:
delib.module {
  name = "nixpkgs";

  darwin.always = {
    nixpkgs.config.allowUnfree = true;

    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  nixos.always = {
    nixpkgs.config.allowUnfree = true;

    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };
}
