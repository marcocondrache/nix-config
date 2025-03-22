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

  sops.secrets.k3s-vpn-auth = {
    sopsFile = ../secrets.yaml;
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/rancher" ];
  };

  systemd.services.k3s.path = [ pkgs.tailscale ];

  networking.firewall.allowedTCPPorts = [
    6443
    5001 # spegel
  ];

  # TODO: find a way to provision node external ip from tailscale
  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent";
    tokenFile = config.sops.secrets.k3s-token.path;
    extraFlags = [
      "--vpn-auth-file=${config.sops.secrets.k3s-vpn-auth.path}"
    ];
  };
}
