{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
    lazydocker
    docker-client
    docker-compose
    docker-credential-helpers
  ];

  home.sessionVariables.COLIMA_SAVE_CONFIG = "false";

  services.colima = {
    enable = true;

    profiles.default = {
      isActive = true;
      isService = false;
      setDockerHost = true;

      settings = {
        cpu = 6;
        memory = 4;
        disk = 100;
        arch = "host";
        runtime = "docker";
        vmType = "vz";
        mountType = "virtiofs";
        mountInotify = true;
        rosetta = false;
        binfmt = false;
        sshConfig = false;
        portForwarder = "grpc";
        network = {
          mode = "shared";
          dnsHosts."host.docker.internal" = "host.lima.internal";
        };

        docker = {
          log-opts = {
            max-size = "10m";
            max-file = "3";
          };
          builder.gc = {
            enabled = true;
            defaultKeepStorage = "20GB";
          };
        };
      };
    };
  };
}
