{delib, ...}:
delib.module {
  name = "nix";

  darwin.always = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  home.always = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  nixos.always = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };
}
