{ inputs, ... }:
{
  imports = [ inputs.determinate.darwinModules.default ];

  nix.enable = false;

  determinateNix = {
    enable = true;
    # nix.settings is ignored when Determinate manages nix
    customSettings = {
      eval-cores = 0;
      warn-dirty = false;
      download-buffer-size = 134217728;
      http-connections = 64;
      extra-substituters = [ "https://nkl-sofka.cachix.org" ];
      extra-trusted-public-keys = [
        "nkl-sofka.cachix.org-1:hLg9frFNJynrxe7SSBb/p6pbawlpZmG10bw+wLsTufw="
      ];
      trusted-users = [ "marcocondrache" ];
    };
  };
}
