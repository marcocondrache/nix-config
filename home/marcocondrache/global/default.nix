{
  lib,
  host,
  user,
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
  };

  programs = {
    home-manager.enable = true;
  };
}
