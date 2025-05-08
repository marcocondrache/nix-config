{ lib, ... }:
{
  programs.bun = {
    enable = lib.mkDefault true;
    enableGitIntegration = lib.mkDefault true;
    settings = {
      telemetry = false;

      install = {
        # Avoid polluting the home directory
        globalDir = "/tmp/bun/global";
        globalBinDir = "/tmp/bun/global/bin";
      };

      run = {
        bun = true;
        silent = true;
      };
    };
  };
}
