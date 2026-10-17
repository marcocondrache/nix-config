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
    ./nix.nix
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
