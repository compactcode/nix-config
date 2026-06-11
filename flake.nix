{
  description = "A minimal and declarative development environment that is fast, efficient, and keyboard-centric";

  inputs = {
    agent-skills-nix = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agent-browser-src = {
      url = "github:vercel-labs/agent-browser";
      flake = false;
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    mattpocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
    herdr = {
      url = "github:ogulcancelik/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      # Pinned to 0.27.0; 0.27.1's agent-browser-dashboard-pnpm-deps OOM-kills
      # (exit 137) during pnpm install on aarch64-darwin. Unpin once upstream fixes.
      url = "github:numtide/llm-agents.nix/1f1ede7969673edd1d35764f5c930ecf96487156";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "nix-darwin";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {denix, ...} @ inputs: let
    mkConfigurations = moduleSystem: homeManagerUser:
      denix.lib.configurations {
        inherit moduleSystem homeManagerUser;

        paths = [./hosts ./modules ./rices ./features];

        extensions = with denix.lib.extensions; [
          # https://yunfachi.github.io/denix/extensions/all-extensions#args
          args
          # https://yunfachi.github.io/denix/extensions/all-extensions#base
          (base.withConfig {
            hosts = {
              features.enable = false;
              displays.enable = false;
              type.enable = false;
            };
          })
        ];

        specialArgs = {
          inherit homeManagerUser inputs;
        };
      };
  in {
    nixosConfigurations = mkConfigurations "nixos" "shandogs";
    darwinConfigurations = mkConfigurations "darwin" "shanon";
  };
}
