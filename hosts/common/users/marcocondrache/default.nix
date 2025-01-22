{
  lib,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = lib.mkDefault "/home/marcocondrache";
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
