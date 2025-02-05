{
  lib,
  host,
  pkgs,
  inputs,
  darwin,
  ...
}:
let
  homeModules = import ../../../modules/home-manager;
in
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./fish.nix
  ];

  system = {
    stateVersion = lib.mkDefault "25.05";
  };

  networking.hostName = host;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    sharedModules =
      [
        inputs.sops-nix.homeManagerModules.sops
      ]
      ++ (lib.optionals (!darwin) [
        inputs.impermanence.nixosModules.home-manager.impermanence
      ])
      ++ (builtins.attrValues homeModules);
  };

  environment.shells = [
    pkgs.fish
  ];
}
