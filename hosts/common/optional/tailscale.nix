{ lib, config, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = lib.mkDefault "client";
    authKeyFile = config.sops.secrets.tailscale-key.path;
  };

  sops.secrets.tailscale-key = {
    sopsFile = ../secrets.yaml;
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/tailscale" ];
  };
}
