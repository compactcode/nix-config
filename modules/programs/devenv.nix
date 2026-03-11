{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # development environments
  name = "programs.devenv";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    # trust the devenv cache
    nix.settings = {
      substituters = [
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };

  home.ifEnabled = {
    # pinned for devenv 1.11.2 until 2.x is fixed on macOS (cachix/devenv#2576)
    home.packages = [inputs.nixpkgs-devenv.legacyPackages.${pkgs.system}.devenv];

    # hide cache from git
    programs.git.ignores = [
      ".devenv"
      ".devenv.*"
    ];
  };

  nixos.ifEnabled = {
    # trust the devenv cache
    nix.settings = {
      substituters = [
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
