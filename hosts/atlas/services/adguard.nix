{ lib, config, ... }:
let
  port = 8081;
  domain = "dns.cloud.marcocondrache.com";
in
{
  users.groups.adguard = { };
  users.users.adguard = {
    isSystemUser = true;
    group = "adguard";

    extraGroups = [ "acme" ];
  };

  security.acme.certs = {
    "${domain}" = {
      reloadServices = [ "adguardhome" ];
    };
  };

  services.adguardhome = {
    inherit port;

    enable = true;
    openFirewall = false;
    mutableSettings = false;

    settings = {
      dns = {
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

      tls =
        let
          certDir = config.security.acme.certs."${domain}".directory;
        in
        {
          enabled = true;
          server_name = domain;

          force_https = true;

          port_dns_over_tls = 853;
          port_dns_over_quic = 853;

          allow_unencrypted_doh = false;

          certificate_path = "${certDir}/cert.pem";
          private_key_path = "${certDir}/key.pem";

          strict_sni_check = true;
        };

      os = {
        user = "adguard";
        group = "adguard";
      };
    };
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/AdGuardHome" ];
  };

  networking.firewall.allowedTCPPorts = [ 853 ];
  networking.firewall.allowedUDPPorts = [ 853 ];

  services.nginx = {
    virtualHosts = {
      "${domain}" = {
        forceSSL = true;
        useACMEHost = domain;

        locations."/dns-query" = {
          proxyPass = "https://localhost:${toString port}";
          proxyWebsockets = true;
        };
      };
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
