{ lib, ... }:
{
  users.groups.adguard = { };
  users.users.adguard = {
    isSystemUser = true;
    group = "adguard";
  };

  security.acme.certs = {
    "dns.marcocondrache.com" = {
      reloadServices = [ "adguardhome" ];
      group = "adguard";
    };
  };

  services.adguardhome = {
    enable = true;
    openFirewall = false;
    mutableSettings = false;

    settings = {
      http = {
        address = "0.0.0.0:8081";
      };

      dns = {
        bind_hosts = [ "0.0.0.0" ];

        upstream_dns = [
          "https://1.1.1.1/dns-query"
          "https://1.0.0.1/dns-query"
        ];

        bootstrap_dns = [
          "1.1.1.1"
          "2606:4700:4700::1111"
        ];

        bootstrap_prefer_ipv6 = true;

        upstream_mode = "parallel";
        use_http3_upstreams = true;

        serve_plain_dns = false;
        serve_http3 = true;
        theme = "dark";

        enable_dnssec = true;
      };

      tls = {
        enabled = true;
        server_name = "dns.marcocondrache.com";

        port_https = 0;
        port_dns_over_tls = 853;
        port_dns_over_quic = 853;

        allow_unencrypted_doh = true;

        strict_sni_check = true;
      };

      os = {
        user = "adguard";
        group = "adguard";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 853 ];
  networking.firewall.allowedUDPPorts = [ 853 ];

  services.nginx = {
    virtualHosts = {
      "dns.marcocondrache.com" = {
        forceSSL = true;
        useACMEHost = "dns.marcocondrache.com";
        locations."/" = {
          proxyPass = "http://localhost:8081";
          proxyWebsockets = true;
        };
      };
    };

    tailscaleAuth = {
      virtualHosts = [
        "dns.marcocondrache.com"
      ];
    };
  };

  systemd.services.adguardhome = {
    serviceConfig = {
      User = "adguard";
      Group = "adguard";
      DynamicUser = lib.mkForce false;
    };
  };
}
