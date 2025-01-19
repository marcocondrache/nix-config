{
  lib,
  host,
  user,
  config,
  ...
}:
{
  home = {
    username = user;
    stateVersion = lib.mkDefault "24.11";
  };

  sops = {
    defaultSopsFile = ../../hosts/${host}/secrets.yaml;
    defaultSopsFormat = "yaml";
    gnupg = {
      home = config.home.homeDirectory;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
