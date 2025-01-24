{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.git = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.gitAndTools.gitFull;

    userName = "Marco Mihai Condrache";
    userEmail = lib.mkDefault "52580954+marcocondrache@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = lib.mkDefault true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
