{ lib, ... }:
{
  programs.bun = {
    enable = lib.mkDefault true;
    enableGitIntegration = lib.mkDefault true;
    settings = {
      telemetry = false;

      run = {
        bun = true;
        silent = true;
      };
    };
  };
}
