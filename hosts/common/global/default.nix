{
  lib,
  host,
  pkgs,
  inputs,
  ...
}:
let
  homeModules = import ../../modules/home-manager;
in
{
  imports = [
    ./nix.nix
    ./locale.nix
  ];

  system = {
    stateVersion = lib.mkDefault "24.11";
  };

  networking = {
    hostName = host;
    computerName = host;
    localHostName = host;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ] ++ (builtins.attrValues homeModules);
  };

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];
}
