{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
    colima
    lazydocker
    docker-client
    docker-compose
    docker-credential-helpers
  ];
}
