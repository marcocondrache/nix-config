{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Taps
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      lib = import ./lib { inherit self inputs nixpkgs; } // nixpkgs.lib;
      eachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (system: nixpkgs.legacyPackages.${system});
    in
    {
      inherit lib;

      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      darwinConfigurations = {
        # Personal laptop
        quemo = lib.mkSystem {
          host = "quemo";
          system = "aarch64-darwin";
          darwin = true;
        };

        # Work laptop
        xawed = lib.mkSystem {
          host = "xawed";
          system = "aarch64-darwin";
          darwin = true;
        };
      };
    };
}
