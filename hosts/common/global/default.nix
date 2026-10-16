{
  name,
  pkgs,
  inputs,
  ...
}:
let
  homeModules = import ../../../modules/home-manager;
  darwinModules = import ../../../modules/darwin;
in
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./fish.nix
  ]
  ++ (builtins.attrValues darwinModules);

  networking.hostName = name;

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
      inherit inputs;
    };

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ]
    ++ (builtins.attrValues homeModules);
  };

  environment.shells = [
    pkgs.fish
  ];
}
