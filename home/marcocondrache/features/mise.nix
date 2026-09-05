{ pkgs, lib, ... }:
{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;

    globalConfig = {
      settings = {
        github = {
          credential_command = "${lib.getExe pkgs.gh} auth token";
        };
      };
    };
  };
}
