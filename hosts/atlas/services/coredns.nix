{
  services.coredns = {
    enable = true;

    config = ''
      ts.marcocondrache.com {
        rewrite stop {
          name regex (.*)\.ts\.marcocondrache\.com {1}.tail13f4af.ts.net
          answer auto
        }
        
        forward . 100.100.100.100
        
        cache
      }
    '';
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
}
