{
  lib,
  pkgs,
  config,
  ...
}:
let
  home = "/home/marcocondrache";
in
{
  users.users.marcocondrache = {
    inherit home;

    name = "marcocondrache";
    shell = pkgs.fish;

    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets.marcocondrache-password.path;
    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  sops.secrets.marcocondrache-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  sops.gnupg = {
    inherit home;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
