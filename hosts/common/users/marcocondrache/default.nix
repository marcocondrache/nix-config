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
    # TODO: Remove this
    hashedPassword = "$y$j9T$ewkEGtoiyVqkkk6Bbp/Fi.$gJT7FL7KIJLrOu7LhMoBdyIVlOI.0IP8TBU19pU2gK1";
    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/marcocondrache/ssh.pub
    );
  };

  # sops.secrets.marcocondrache-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.marcocondrache = import ../../../../home/marcocondrache/${config.networking.hostName}.nix;
}
