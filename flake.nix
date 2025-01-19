{
  description = "Marco's system configuration";

  inputs = {
    # Dangerous, but it's the only way to get bun fixed
    # https://discourse.nixos.org/t/icu-symbol-not-found-with-node-and-bun/58566/3
    nixpkgs.url = "github:NixOS/nixpkgs?ref=staging-next";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      colmena,
      nix-darwin,
      home-manager,
      sops-nix,
      ...
    }:
    let
      lib = import ./lib inputs // nixpkgs.lib;
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

      colmenaHive = colmena.lib.makeHive self.outputs.colmena;
      colmena = lib.mkColmenaConfig {
        workers = {
          host = "ivoyo";
          count = 2;
        };

        masters = {
          host = "ajavo";
          count = 1;
        };
      };
    };
}
