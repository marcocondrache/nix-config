{ config, ... }:
{
  services.headscale = {
    enable = true;
    address = "127.0.0.1";
    port = 8081;
    settings = {
      database = {
        sqlite = {
          path = "/var/lib/headscale/db.sqlite";
        };
      };
      server_url = "https://tailscale.marcocondrache.com";
      dns = {
        magic_dns = true;
        base_domain = "ts.marcocondrache.com";
        nameservers.global = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        search_domains = [
          "marcocondrache.com"
        ];
      };
      log = {
        level = "warn";
      };
      logtail = {
        enabled = false;
      };
    };
  };

  # services.litestream = {
  #   settings = {
  #     dbs = [
  #       {
  #         path = "/var/lib/headscale/db.sqlite";
  #         replicas = [ ];
  #       }
  #     ];
  #   };
  # };

  services.nginx = {
    virtualHosts = {
      "tailscale.marcocondrache.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.headscale.port}";
          proxyWebsockets = true;
        };
      };
    };
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/headscale" ];
  };
}
