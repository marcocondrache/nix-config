{ lib, ... }:
{
  programs.gh = {
    enable = lib.mkDefault true;
    gitCredentialHelper.enable = lib.mkDefault true;
  };
}
