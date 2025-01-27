{
  lib,
  pkgs,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = lib.mkDefault "/home/marcocondrache";
    shell = pkgs.fish;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
