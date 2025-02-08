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

    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets.marcocondrache-password.path;
    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  sops = {
    gnupg = {
      home = config.home.homeDirectory;
    };

    secrets.marcocondrache-password = {
      sopsFile = ../../secrets.yaml;
      neededForUsers = true;
    };
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
