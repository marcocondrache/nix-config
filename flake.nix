{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kubef.url = "github:marcocondrache/kubef";
    kubef.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      lib = import ./lib { inherit inputs; } // nixpkgs.lib;
    in
    {
      darwinConfigurations = {
        # Personal laptop
        quemo = lib.mkSystem {
          host = "quemo";
          system = "aarch64-darwin";
        };

        # Work laptop
        xawed = lib.mkSystem {
          host = "xawed";
          system = "aarch64-darwin";
        };
      };
    };
}
