{ config, ... }:
let
  data_dir = "/home/opuser/.op/data";
  credentials_file = "/home/opuser/.op/1password-credentials.json";
in
{
  # Create a dedicated network for 1Password containers
  environment.etc."containers/networks/op-network.json" = {
    mode = "0644";
    text = builtins.toJSON {
      dns_enabled = true;
      driver = "bridge";
      id = "1111111111111111111111111111111111111111111111111111111111111111";
      internal = false;
      ipam_options = {
        driver = "host-local";
      };
      ipv6_enabled = false;
      name = "op-network";
      network_interface = "op-network0";
      subnets = [
        {
          gateway = "192.168.200.1";
          subnet = "192.168.200.0/24";
        }
      ];
    };
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
        extraOptions = [ "--network=op-network" ];
      };
      onepassword-sync = {
        image = "docker.io/1password/connect-sync:latest";
        volumes = [
          "onepassword:${data_dir}"
          "${config.sops.secrets.onepassword-credentials.path}:${credentials_file}"
        ];
        extraOptions = [ "--network=op-network" ];
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
