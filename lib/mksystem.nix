{ inputs }:
{
  host,
  system,
}:
let
  hostConfig = import (../hosts + "/${host}");
in
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit host inputs;
  };

  modules = [
    { nixpkgs.hostPlatform = system; }
    inputs.home-manager.darwinModules.home-manager
    hostConfig
  ];
}
