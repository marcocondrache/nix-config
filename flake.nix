{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # No nixpkgs follows so the package substitutes from nkl-sofka.cachix.org
    sofka.url = "github:nklmilojevic/sofka";
    sofka.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      lib = import ./lib { inherit inputs; } // nixpkgs.lib;
    in
    {
      inherit lib;

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;

      darwinConfigurations = {
        # Work laptop
        xawed = lib.mkSystem {
          host = "xawed";
          system = "aarch64-darwin";
        };
      };
    };
}
