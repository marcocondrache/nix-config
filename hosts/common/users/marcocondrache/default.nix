{
  lib,
  pkgs,
  host,
  ...
}:
{
  users.mutableUsers = false;
  users.users.marcocondrache = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${host}.nix;
}
