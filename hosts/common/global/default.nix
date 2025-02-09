{
  lib,
  host,
  pkgs,
  hosts,
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

    extraSpecialArgs = {
      inherit hosts darwin;
    };

    sharedModules = [
      #inputs.sops-nix.homeManagerModules.sops
    ] ++ (builtins.attrValues homeModules);
  };

  environment.shells = [
    pkgs.fish
  ];
}
