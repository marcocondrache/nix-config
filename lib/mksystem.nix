{
  nixpkgs,
  inputs,
  outputs,
}:
{
  host,
  system,
  darwin ? false,
  name ? host,
}:
let
  lib = nixpkgs.lib;

  # TODO: Add darwin hosts
  hosts = lib.attrNames (outputs.nixosConfigurations);

  hostConfig = import (../hosts + "/${host}");
  systemFunction = if darwin then inputs.nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;

  home-manager =
    if darwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
systemFunction {
  inherit system;

  specialArgs = {
    inherit host;
    inherit name;
    inherit hosts;
    inherit darwin;
    inherit inputs;
  };

  modules =
    (lib.optionals (!darwin) [
      inputs.disko.nixosModules.disko
    ])
    ++ [
      home-manager
      hostConfig
    ];
}
