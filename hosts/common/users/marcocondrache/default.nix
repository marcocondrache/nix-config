{
  config,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
