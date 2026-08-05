{delib, ...}: let
  # https://github.com/NixOS/nixpkgs/issues/507531: cache.nixos.org served
  # aarch64-darwin binaries with corrupt Mach-O signatures, so any checkPhase
  # exec'ing an affected interpreter (fish, zsh, ...) got SIGKILLed mid-test.
  # Looks resolved — direnv 2.37.1 and fish 4.8.1 now substitute from cache and
  # pass codesign --verify, so this overlay only forces a needless local
  # rebuild. Candidate for removal.
  direnvOverlay = _final: prev: {
    direnv = prev.direnv.overrideAttrs (_: {doCheck = false;});
  };
in
  delib.module {
    name = "nixpkgs";

    darwin.always = {
      nixpkgs.config.allowUnfree = true;

      nixpkgs.overlays = [
        direnvOverlay
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
