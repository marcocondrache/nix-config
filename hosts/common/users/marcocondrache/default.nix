{
  lib,
  pkgs,
  host,
  config,
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

    hashedPasswordFile = config.sops.secrets.marcocondrache-password.path;
    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  sops.secrets.marcocondrache-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${host}.nix;
}
