{ lib, config, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    extraUpFlags = [ "--login-server=https://tailscale.marcocondrache.com" ];
  };

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  environment.persistence = {
    "/persist".directories = [ "/var/lib/tailscale" ];
  };
}
