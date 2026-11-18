{
  lib,
  pkgs,
  config,
  ...
}:
{
  users.users.marcocondrache = {
    isNormalUser = true;
    # The Mac's ssh config forwards gpg-agent to /run/user/1000
    uid = 1000;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ] ++ lib.optional config.virtualisation.docker.enable "docker";
    openssh.authorizedKeys.keyFiles = [ ../../../../home/marcocondrache/ssh.pub ];
    # Starts the user manager at boot so /run/user/1000/gnupg exists before the first ssh
    linger = true;
  };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
