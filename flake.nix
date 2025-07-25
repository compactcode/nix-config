{
  description = "A minimal and declarative development environment that is fast, efficient, and keyboard-centric";

  inputs = {
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

        specialArgs = {
          inherit homeManagerUser inputs;
        };
      };
  in {
    nixosConfigurations = mkConfigurations "nixos" "shandogs";
    darwinConfigurations = mkConfigurations "darwin" "shanon";
  };
}
