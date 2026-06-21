{ pkgs, config, ... }:
{
  # nix-output-monitor gives nh readable, structured build progress
  home.packages = [ pkgs.nix-output-monitor ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/Personal/nix-config";
  };
}
