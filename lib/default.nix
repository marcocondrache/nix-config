{
  self,
  inputs,
  ...
}:
{
  mkHomeManagerConfig =
    {
      settings,
    }:
    {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${settings.user} = import (../home + "/${settings.user}" + "/${settings.host}.nix");
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
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
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        (../hosts + "/${host}")
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = self.lib.mkHomeManagerConfig {
            inherit settings;
          };
        }
      ];
      specialArgs = settings;
    };

  mkColmenaHost =
    {
      host,
      index,
      user ? "marcocondrache",
      system ? "aarch64-linux",
      isMaster ? false,
    }:
    {
      imports = [
        (../hosts + "/${host}")
      ];

      deployment = {
        allowLocalDeployment = false;
        buildOnTarget = true;
        tags = [
          "worker"
          "master"
        ];
      };
    };

  mkColmenaConfig =
    {
      workers,
      masters,
    }:
    let
      inherit (self.lib) mkColmenaHost;

      workersCount = builtins.genList (x: x + 1) workers.count;
      mastersCount = builtins.genList (x: x + 1) masters.count;

      workersDefinition = builtins.map (num: {
        name = "${workers.host}-${toString num}";
        value = mkColmenaHost {
          host = workers.host;
          index = num;
        };
      }) workersCount;

      mastersDefinition = builtins.map (num: {
        name = "${masters.host}-${toString num}";
        value = mkColmenaHost {
          host = masters.host;
          index = num;
          isMaster = true;
        };
      }) mastersCount;
    in

    builtins.listToAttrs (workersDefinition ++ mastersDefinition);
}
