{
  host,
  pkgs,
  inputs,
  ...
}:
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
  };

  environment.shells = [
    pkgs.fish
  ];
}
