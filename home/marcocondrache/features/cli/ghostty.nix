{ lib }:
{
  programs.ghostty = {
    enable = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault true;
  };
}
