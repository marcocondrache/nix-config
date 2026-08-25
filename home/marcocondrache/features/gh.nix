{ lib, pkgs, ... }:
{
  programs.gh = {
    enable = lib.mkDefault true;
    gitCredentialHelper.enable = false;

    extensions = [ pkgs.gh-stack ];

    settings = {
      git_protocol = "ssh";
    };
  };
}
