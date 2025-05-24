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

    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  system.primaryUser = "marcocondrache";

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
