{
  lib,
  config,
  osConfig,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "24.11";
  };

  sops = {
    defaultSopsFile = ../../hosts/${osConfig.networking.hostName}/secrets.yaml;
    defaultSopsFormat = "yaml";
    gnupg = {
      home = config.home.homeDirectory;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
