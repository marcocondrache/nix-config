{ pkgs, ... }:
{
  #home.username = username;
  #home.homeDirectory = "/Users/${username}";

  home.packages = with pkgs; [
    bun

    # only available to linux
    # code-cursor
    raycast
  ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
