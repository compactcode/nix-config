{delib, ...}:
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
    programs.devenv = {
      enable = true;
      enableZshIntegration = true;
    };

    # hide cache from git
    programs.git.ignores = [
      ".devenv"
      ".devenv.*"
    ];

    programs.claude-code.settings.permissions.allow = ["WebFetch(domain:devenv.sh)"];
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
