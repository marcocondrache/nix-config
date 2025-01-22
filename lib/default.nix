{
  self,
  inputs,
  ...
}:
{
  mkPkgs =
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: import ../pkgs { pkgs = prev; })
      ];
    };

  mkHomeManagerConfig =
    {
      settings,
    }:
    let
      modules = import ../modules/home-manager;
    in
    {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${settings.user} = import (../home + "/${settings.user}" + "/${settings.host}.nix");
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ] ++ (builtins.attrValues modules);
      extraSpecialArgs = settings;
    };

  mkDarwinConfig =
    {
      host,
      user ? "marcocondrache",
      system ? "aarch64-darwin",
    }:
    let
      inherit (self.lib) mkPkgs;

      pkgs = mkPkgs system;
      settings = {
        inherit host user system;
      };
    in
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = settings // {
        inherit pkgs;
      };

      modules = [
        (../hosts + "/${host}")
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nixpkgs.pkgs = pkgs;

          nix-homebrew = {
            inherit user;

            taps = {
              "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
            };

            enable = true;
            autoMigrate = true;
            mutableTaps = false;
          };

          home-manager = self.lib.mkHomeManagerConfig {
            inherit settings;
          };
        }
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
    let
      pkgs = self.lib.mkPkgs system;
    in
    {
      imports = [
        (../hosts + "/${host}")
      ];

      nixpkgs.pkgs = pkgs;
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
