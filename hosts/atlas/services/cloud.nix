{
  security.acme.certs = {
    "cloud.marcocondrache.com" = {
      reloadServices = [
        "nginx"
      ];

      extraDomainNames = [ "*.cloud.marcocondrache.com" ];
    };
  };

  services.nginx = {
    virtualHosts = {
      localhost = {
        forceSSL = true;
        useACMEHost = "cloud.marcocondrache.com";

        serverAliases = [
          "127.0.0.1"
          "cloud.marcocondrache.com"
        ];

        listenAddresses = [ "0.0.0.0" ];
      };
    };
  };
}
