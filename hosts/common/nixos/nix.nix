{ inputs, ... }:
{
  imports = [ inputs.determinate.nixosModules.default ];

  nix.settings = import ../global/nix-settings.nix;

  programs.nh.clean = {
    enable = true;
    dates = "weekly";
    extraArgs = "--keep 10 --keep-since 14d";
  };
}
