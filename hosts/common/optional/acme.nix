{ config, ... }:
{
  sops.secrets.cloudflare-api-token = {
    sopsFile = ../secrets.yaml;
  };

  security.acme = {
    acceptTerms = true;
    preliminarySelfsigned = false;

    defaults = {
      email = "52580954+marcocondrache@users.noreply.github.com";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.sops.secrets.cloudflare-api-token.path;
      };
    };
  };

  environment.persistence = {
    "/persist" = {
      directories = [ "/var/lib/acme" ];
    };
  };
}
