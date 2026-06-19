{
  nix.enable = false;

  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
      extra-substituters = [
        "https://zed.cachix.org"
        "https://devenv.cachix.org"
      ];
      extra-trusted-public-keys = [
        "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
