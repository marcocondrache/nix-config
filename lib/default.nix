{
  self,
  inputs,
  ...
}:
{
  mkDarwinConfig =
    {
      host,
      system ? "aarch64-darwin",
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = {
        inherit host;
        inherit inputs;
      };

      modules = [
        inputs.home-manager.darwinModules.home-manager
        (../hosts + "/${host}")
      ];
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
        targetUser = user;
        targetHost = "${host}-${toString index}";
        tags = if isMaster then [ "master" ] else [ "worker" ];
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
