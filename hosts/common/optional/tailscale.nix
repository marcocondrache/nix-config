{ lib, config, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  environment.persistence = {
    "/persist".directories = [ "/var/lib/tailscale" ];
  };
}
