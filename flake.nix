{
  description = "Marco's system configuration";

  inputs = {
    # Dangerous, but it's the only way to get bun fixed
    # https://discourse.nixos.org/t/icu-symbol-not-found-with-node-and-bun/58566/3
    nixpkgs.url = "github:NixOS/nixpkgs?ref=staging-next";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      lib = import ./lib { inherit self inputs; };
    in
    {
      inherit lib;

      darwinConfigurations = {
        # Personal laptop
        quemo = lib.mkDarwinConfig {
          host = "quemo";
        };

        # Work laptop
        xawed = lib.mkDarwinConfig {
          host = "xawed";
        };
      };

      colmena =
        {
          meta = {
            nixpkgs = lib.mkPkgs "aarch64-linux";
          };

          defaults = {
            imports = [
              inputs.hardware.nixosModules.raspberry-pi-4
            ];
          };
        }
        // lib.mkColmenaConfig {
          workers = {
            host = "ivoyo";
            count = 1;
          };

          masters = {
            host = "ajavo";
            count = 1;
          };
        };
    };
}
