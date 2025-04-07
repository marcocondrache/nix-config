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
  ];

  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent";
    tokenFile = config.sops.secrets.k3s-token.path;
  };
}
