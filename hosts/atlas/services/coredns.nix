{
  services.coredns = {
    enable = true;

    config = ''
      ts.marcocondrache.com {
        rewrite name regex (.*)\.ts\.marcocondrache\.com {1}.tailnet.com
        forward . 100.100.100.100
        cache
      }
    '';
  };
}
