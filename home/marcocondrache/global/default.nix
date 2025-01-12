{
  lib,
  host,
  user,
  config,
  ...
}:
{
  imports = [
    ../features/cli
  ];

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
