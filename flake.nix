{
  description = "A minimal and declarative development environment that is fast, efficient, and keyboard-centric";

  inputs = {
    agent-skills-nix = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agent-superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # pinned for devenv 1.11.2 until 2.x is fixed on macOS (cachix/devenv#2576)
    nixpkgs-devenv.url = "github:nixos/nixpkgs/80bdc1e5ce51f56b19791b52b2901187931f5353";
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
