{ inputs }:
{
  host,
  system,
  name ? host,
}:
let
  hostConfig = import (../hosts + "/${host}");
in
inputs.nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit host name inputs;
  };

  modules = [
    inputs.home-manager.darwinModules.home-manager
    hostConfig
  ];
}
