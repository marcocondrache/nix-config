{ config, ... }:
{
  security.acme.certs = {
    "ts.marcocondrache.com" = {
      extraDomainNames = [ "*.ts.marcocondrache.com" ];
      reloadServices = [ "coredns" ];
    };
  };

  services.coredns =
    let
      certDir = config.security.acme.certs."ts.marcocondrache.com".directory;
    in
    {
      enable = true;

      config = ''
        https://ts.marcocondrache.com {
          tls ${certDir}/cert.pem ${certDir}/key.pem ${certDir}/chain.pem

          rewrite stop {
            name regex (.*)\.ts\.marcocondrache\.com {1}.tail13f4af.ts.net
            answer auto
          }
          
          forward . 100.100.100.100
        }
      '';
    };

  networking.firewall.allowedUDPPorts = [ 53 ];
}
