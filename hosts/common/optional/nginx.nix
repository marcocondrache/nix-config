{ config, lib, ... }:
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;

    tailscaleAuth = {
      enable = true;
    };
  };

  users.users.nginx.extraGroups = lib.mkIf config.security.acme.acceptTerms [ "acme" ];

  networking.firewall.allowedTCPPorts = [
    config.services.nginx.defaultHTTPListenPort
    config.services.nginx.defaultSSLListenPort
  ];
}
