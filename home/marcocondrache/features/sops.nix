{ config, ... }:
{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSymlinkPath = "${config.home.homeDirectory}/.secrets";
  };
}
