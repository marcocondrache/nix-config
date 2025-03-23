{
  config,
  pkgs,
  lib,
  ...
}:
{
  sops.secrets.k3s-token = {
    sopsFile = ../secrets.yaml;
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/rancher" ];
  };

  networking.firewall.allowedTCPPorts = [
    6443
    5001 # spegel
  ];

  services.tailscale = {
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--accept-routes"
      "--advertise-routes=10.42.0.0/16,10.43.0.0/16"
    ];
  };

  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent";
    tokenFile = config.sops.secrets.k3s-token.path;
    extraFlags = [
      "--vpn-auth-file=${config.sops.secrets.k3s-vpn-auth.path}"
    ];
  };

  # Manually connect to tailscale
  systemd.services.k3s = {
    after = [ "tailscaled-autoconnect.service" ];
    wants = [ "tailscaled-autoconnect.service" ];

    path = [ pkgs.tailscale ];
  };
}
