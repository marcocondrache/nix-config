{ config, ... }:
let
  dockerEnabled = config.virtualisation.docker.enable;
in
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = !dockerEnabled;
    dockerSocket.enable = !dockerEnabled;
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/containers" ];
  };
}
