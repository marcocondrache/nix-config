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
      key = null;
      # TODO: enable this
      signByDefault = lib.mkDefault false;
      gpgPath = "${config.programs.gpg.package}/bin/gpg2";
    };

    extraConfig = {
      init.defaultBranch = "main";

      diff.algorithm = "histogram";
      merge.conflictStyle = "zdiff3";
      push.autoSetupRemote = true;
    };

    ignores = [
      ".npmrc"
    ];
  };
}
