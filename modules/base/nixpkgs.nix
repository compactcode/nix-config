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
