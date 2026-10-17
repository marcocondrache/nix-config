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
      trusted-users = [ "marcocondrache" ];
    };
  };
}
