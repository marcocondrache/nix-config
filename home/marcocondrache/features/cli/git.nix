{
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.gitAndTools.gitFull;

    userName = "Marco Mihai Condrache";
    extraDefault = {
      init.defaultBranch = "main";
    };
  };
}
