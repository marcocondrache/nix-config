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
    signing = {
      key = "209101AD5F0E04C6";
      format = "openpgp";
      signByDefault = lib.mkDefault true;
      signer = "${config.programs.gpg.package}/bin/gpg2";
    };

    extraConfig = {
      init.defaultBranch = "main";

      diff.algorithm = "histogram";
      merge.conflictStyle = "zdiff3";

      commit.verbose = true;

      push.autoSetupRemote = true;
      branch.sort = "committerdate";
    };

    delta = {
      enable = true;
    };

    ignores = [
      ".npmrc"
      ".direnv"
    ];
  };
}
