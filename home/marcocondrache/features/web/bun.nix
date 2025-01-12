{ lib, ... }:
{
  programs.bun = {
    enable = lib.mkDefault true;
    enableGitIntegration = lib.mkDefault true;
  };
}
