{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      #nixpkgs,
      ...
    }:
    let
      #lib = nixpkgs.lib // home-manager.lib;

      mkDarwinConfig =
        {
          host,
          user ? "marcocondrache",
          system ? "aarch64-darwin",
        }:
        let
          settings = {
            inherit host user system;
          };
        in
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            (./hosts + "/${host}")
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${user} = import (./home + "/${user}" + "/${host}.nix");
              home-manager.extraSpecialArgs = settings;
            }
          ];
          specialArgs = settings;
        };
    in
    {
      darwinConfigurations = {
        # Personal laptop
        quemo = mkDarwinConfig {
          host = "quemo";
        };

        # Work laptop
        xawed = mkDarwinConfig {
          host = "xawed";
        };
      };
    };
}
