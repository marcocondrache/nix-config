{
  lib,
  pkgs,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ] ++ lib.optional config.virtualisation.docker.enable "docker";
    openssh.authorizedKeys.keyFiles = [ ../../../../home/marcocondrache/ssh.pub ];
    linger = true;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
