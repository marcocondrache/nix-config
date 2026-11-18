{
  host,
  pkgs,
  inputs,
  ...
}:
let
  homeModules = import ../../../modules/home-manager;
in
{
  imports = [
    ./locale.nix
    ./fish.nix
  ];

  networking.hostName = host;

  # Saves ~5% of eval; user package man pages still resolve through PATH
  documentation.enable = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs;
    };

    sharedModules = builtins.attrValues homeModules;
  };

  environment.shells = [
    pkgs.fish
  ];
}
