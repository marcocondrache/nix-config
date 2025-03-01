{ config, ... }:
{
  sops.secrets.litestream = {
    sopsFile = ../secrets.yaml;
  };

  services.litestream = {
    enable = true;
    environmentFile = config.sops.secrets.litestream.path;
  };
}
