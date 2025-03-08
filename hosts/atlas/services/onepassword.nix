{ config, ... }:
let
  data_dir = "/home/opuser/.op/data";
  credentials_file = "/home/opuser/.op/1password-credentials.json";
in
{
  sops.secrets.onepassword-credentials = {
    sopsFile = ../secrets.yaml;
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      onepassword-connect = {
        image = "docker.io/1password/connect-api:latest";
        ports = [ "8080:8080" ];
        volumes = [
          "onepassword:${data_dir}"
          "${config.sops.secrets.onepassword-credentials.path}:${credentials_file}"
        ];
      };
      onepassword-sync = {
        image = "docker.io/1password/connect-sync:latest";
        volumes = [
          "onepassword:${data_dir}"
          "${config.sops.secrets.onepassword-credentials.path}:${credentials_file}"
        ];
      };
    };
  };
}
