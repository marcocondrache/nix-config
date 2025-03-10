{ pkgs, ... }:
{
  services.coredns = {
    enable = true;
    package = pkgs.coredns.override {
      externalPlugins = [
        {
          name = "tailscale";
          repo = "github.com/damomurf/coredns-tailscale";
          version = "v0.3.13";
        }
      ];

      vendorHash = "";
    };

    config = ''
      ts.marcocondrache.com:53 {
        tailscale ts.marcocondrache.com

        log
        errors
      }
    '';
  };
}
