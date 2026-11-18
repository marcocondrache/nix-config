{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
    lazydocker
    docker-client
    docker-compose
    docker-credential-helpers
  ];
}
