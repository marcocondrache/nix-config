{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    rex.url = "https://pkgs.superlogical.com/rex/nix/preview.tar.gz";
    rex.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      lib = import ./lib { inherit inputs; } // nixpkgs.lib;
    in
    {
      inherit lib;

      formatter = nixpkgs.lib.genAttrs [ "aarch64-darwin" "aarch64-linux" ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-tree
      );

      darwinConfigurations = {
        xawed = lib.mkSystem {
          host = "xawed";
          system = "aarch64-darwin";
        };
      };

      nixosConfigurations = {
        devbox = lib.mkSystem {
          host = "devbox";
          system = "aarch64-linux";
        };
      };
    };
}
