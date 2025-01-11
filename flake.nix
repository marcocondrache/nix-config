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
          username ? "marcocondrache",
          arch ? "aarch64-darwin",
        }:
        nix-darwin.lib.darwinSystem {
          system = arch;
          modules = [
            (./hosts + "/${host}")
            home-manager.darwinModules.home-manager
            {
              networking.hostName = host;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import (./home + "/${username}" + "/${host}.nix");
            }
          ];
          specialArgs = {
            inherit
              host
              username
              arch
              ;
          };
        };
    in
    {
      darwinConfigurations = {
        # Personal laptop
        quemo = mkDarwinConfig {
          host = "quemo";
        };

        # Work laptop
        # xawed = mkDarwinConfig {
        #   host = "xawed";
        # };
      };
    };
}
