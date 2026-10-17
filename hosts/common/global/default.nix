{
  name,
  pkgs,
  inputs,
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
      inputs.sofka.homeManagerModules.default
    ]
    ++ (builtins.attrValues homeModules);
  };

  environment.shells = [
    pkgs.fish
  ];
}
