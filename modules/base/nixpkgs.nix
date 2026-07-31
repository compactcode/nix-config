{delib, ...}: let
  # pandas-stubs' tests error during collection under pytest 9: they pass
  # generators to @pytest.mark.parametrize (PytestRemovedIn10Warning) and its
  # pyproject sets filterwarnings = ["error"]. pdfplumber lists it in
  # nativeCheckInputs, breaking the `pdf` agent skill's python env.
  # pythonImportsCheck must be cleared too: it imports pandas, which only
  # reaches the build env via the nativeCheckInputs that doCheck = false drops.
  # Fixed upstream by https://github.com/NixOS/nixpkgs/pull/545267 (merged
  # 2026-07-29, ~1h after our pin); drop this on the next nixpkgs bump.
  pandasStubsOverlay = _final: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (_pyfinal: pyprev: {
          pandas-stubs = pyprev.pandas-stubs.overridePythonAttrs (_: {
            doCheck = false;
            pythonImportsCheck = [];
          });
        })
      ];
  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/507531:
  # cache.nixos.org is currently serving aarch64-darwin binaries with
  # invalid macOS code signatures, so any checkPhase that exec's an
  # affected interpreter (fish, zsh, ...) gets SIGKILLed mid-test.
  # Disable direnv's checkPhase until the upstream Nix fix
  # (https://github.com/NixOS/nix/pull/15638) lands and Hydra rebuilds.
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
        pandasStubsOverlay
      ];

      environment.variables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };
    };

    nixos.always = {
      nixpkgs.config.allowUnfree = true;

      nixpkgs.overlays = [
        pandasStubsOverlay
      ];

      environment.variables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };
    };
  }
