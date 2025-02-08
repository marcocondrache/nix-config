{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
  };

  networking.firewall.allowedTCPPorts = [
    config.services.nginx.defaultHTTPListenPort
    config.services.nginx.defaultSSLListenPort
  ];

  security.acme = {
    defaults.email = "52580954+marcocondrache@users.noreply.github.com";
    acceptTerms = true;
  };

  environment.persistence = {
    "/persist" = {
      directories = [ "/var/lib/acme" ];
    };
  };
}
