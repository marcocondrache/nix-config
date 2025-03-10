{
  services.coredns = {
    enable = true;

    config = ''
      ts.marcocondrache.com {
        rewrite name regex (.*)\.ts\.marcocondrache\.com {1}.tail13f4af.ts.net
        forward . 100.100.100.100
        cache
      }
    '';
  };
}
