{
  lib,
  pkgs,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = lib.mkDefault "/Users/marcocondrache";
    shell = pkgs.fish;
  };

  system.primaryUser = "marcocondrache";

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
