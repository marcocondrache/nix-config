{ config, ... }:
{
  services.headscale = {
    enable = true;
    address = "127.0.0.1";
    port = 8080;
    settings = {
      server_url = "https://tailscale.marcocondrache.com";
      dns = {
        override_local_dns = true;
        base_domain = "ts.marcocondrache.com";
        magic_dns = true;
        nameservers.global = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
  };

  services.nginx = {
    virtualHosts = {
      "tailscale.marcocondrache.com" = {
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.headscale.port}";
          proxyWebsocket = true;
        };
      };
    };
  };
}
