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
      ...
    }:
    let
      username = "marcocondrache";

      createDarwinConfig =
        {
          host,
          system ? "aarch64-darwin",
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            (./hosts + "/${host}")
            home-manager.darwinModules.home-manager
            {
              networking.hostName = host;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home + "/${username}" + "/${host}.nix";
            }
          ];
          specialArgs = {
            inherit host username system;
          };
        };
    in
    {
      darwinConfigurations = {
        # Personal laptop
        quemo = createDarwinConfig {
          host = "quemo";
        };

        # Work laptop
        xawed = createDarwinConfig {
          host = "xawed";
        };
      };
    };
}
