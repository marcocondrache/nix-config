{
  description = "Marco's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      sops-nix,
      ...
    }:
    let
      mkHomeManagerConfig =
        {
          settings,
        }:
        {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.${settings.user} = import (./home + "/${settings.user}" + "/${settings.host}.nix");
          sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
          extraSpecialArgs = settings;
        };

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
              home-manager = mkHomeManagerConfig {
                inherit settings;
              };
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
