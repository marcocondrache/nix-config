{ pkgs, username, ... }: {
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.packages = with pkgs; [
    bun
    
    code-cursor
    raycast
  ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}