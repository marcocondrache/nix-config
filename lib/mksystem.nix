{
  nixpkgs,
  inputs,
  ...
}:
{
  host,
  system,
  darwin ? false,
  name ? host,
}:
let
  lib = nixpkgs.lib;

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
    inherit darwin;
    inherit inputs;
  };

  modules =
    (lib.optionals (!darwin) [
      inputs.disko.nixosModules.disko
    ])
    ++ (lib.optionals darwin [
      inputs.determinate.darwinModules.default
    ])
    ++ [
      home-manager
      hostConfig
    ];
}
