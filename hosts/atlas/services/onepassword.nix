{ config, ... }:
let
  data_dir = "/home/opuser/.op/data";
  credentials_file = "/home/opuser/.op/1password-credentials.json";
in
{

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      onepassword-connect = {
        image = "docker.io/1password/connect-api:latest";
        ports = [ "8080:8090" ];
        volumes = [
          "onepassword:${data_dir}"
          "${config.sops.secrets.onepassword-credentials.path}:${credentials_file}"
        ];
        extraOptions = [ "--network=host" ];
      };
      onepassword-sync = {
        image = "docker.io/1password/connect-sync:latest";
        volumes = [
          "onepassword:${data_dir}"
          "${config.sops.secrets.onepassword-credentials.path}:${credentials_file}"
        ];
        extraOptions = [ "--network=host" ];
      };
    };
  };

  sops.secrets.onepassword-credentials = {
    sopsFile = ../secrets.yaml;

    restartUnits = [
      "${config.virtualisation.oci-containers.containers.onepassword-sync.serviceName}.service"
      "${config.virtualisation.oci-containers.containers.onepassword-connect.serviceName}.service"
    ];

    # TODO: https://github.com/1Password/connect/issues/32
    mode = "444";
  };
}
