{ nixpkgs, inputs }:
{
  host,
  system,
  darwin ? false,
}:
let
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
    inherit inputs;
  };

  modules = [
    home-manager
    hostConfig
  ];
}
