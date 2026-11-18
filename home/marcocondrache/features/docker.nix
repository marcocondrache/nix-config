{ pkgs, config, ... }:
{
  # The daemon and docker CLI come from virtualisation.docker on the host
  home.packages = with pkgs; [
    dive
    lazydocker
    docker-compose
  ];

  # Not via programs.docker-cli: its read-only config.json breaks `docker login`
  home.sessionVariables.DOCKER_CONFIG = "${config.xdg.configHome}/docker";
}
