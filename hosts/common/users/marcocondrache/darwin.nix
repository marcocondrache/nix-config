{
  pkgs,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = "/Users/marcocondrache";
    shell = pkgs.fish;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
