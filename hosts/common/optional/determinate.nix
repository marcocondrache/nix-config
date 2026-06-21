{
  nix.enable = false;

  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
      trusted-users = [ "marcocondrache" ];
      extra-substituters = [
        "https://zed.cachix.org"
      ];
      extra-trusted-public-keys = [
        "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      ];
    };
  };
}
