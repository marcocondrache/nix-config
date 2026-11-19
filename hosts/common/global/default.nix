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
