{ pkgs, lib, ... }:
{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    mutableSettings = true;

    globalConfig = {
      settings = {
        experimental = true;
        github = {
          credential_command = "${lib.getExe pkgs.gh} auth token";
        };
      };
    };
  };

  # Skip mise's slow command-not-found hook
  programs.fish.interactiveShellInit = lib.mkAfter ''
    function fish_command_not_found
      __fish_default_command_not_found_handler $argv
    end
  '';
}
