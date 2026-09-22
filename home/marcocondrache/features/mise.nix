{ pkgs, lib, ... }:
{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    enableMutableConfig = true;

    globalConfig = {
      settings = {
        experimental = true;
        github = {
          credential_command = "${lib.getExe pkgs.gh} auth token";
        };
      };
    };
  };
}
