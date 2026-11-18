{ inputs }:
{
  host,
  system,
}:
let
  isDarwin = inputs.nixpkgs.lib.hasSuffix "-darwin" system;
  hostConfig = import (../hosts + "/${host}");

  mkSystem = if isDarwin then inputs.nix-darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
  homeManager =
    if isDarwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
mkSystem {
  specialArgs = {
    inherit host inputs;
  };

  modules = [
    { nixpkgs.hostPlatform = system; }
    homeManager
    hostConfig
  ];
}
