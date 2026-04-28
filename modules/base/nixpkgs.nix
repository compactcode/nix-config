{delib, ...}:
delib.module {
  name = "nixpkgs";

  darwin.always = {
    nixpkgs.config.allowUnfree = true;

    # Workaround for https://github.com/NixOS/nixpkgs/issues/507531:
    # cache.nixos.org is currently serving aarch64-darwin binaries with
    # invalid macOS code signatures, so any checkPhase that exec's an
    # affected interpreter (fish, zsh, ...) gets SIGKILLed mid-test.
    # Disable direnv's checkPhase until the upstream Nix fix
    # (https://github.com/NixOS/nix/pull/15638) lands and Hydra rebuilds.
    nixpkgs.overlays = [
      (_final: prev: {
        direnv = prev.direnv.overrideAttrs (_: {doCheck = false;});
      })
    ];

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
