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

  programs.git.settings.alias = {
    pr = "!gh pr create";
    pra = "!gh pr merge --auto -s -d";
  };
}
