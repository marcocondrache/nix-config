{ pkgs, config, ... }:
{
  home.packages = [ pkgs.nix-output-monitor ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/Personal/nix-config";
  };
}
