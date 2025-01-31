{ pkgs, ... }:
{
  home.packages = with pkgs; [
    colima
    lazydocker
    docker-client
    docker-compose
    docker-credential-helpers
  ];
}
