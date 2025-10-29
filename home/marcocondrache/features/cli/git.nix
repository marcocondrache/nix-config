{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.git = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.gitFull;

    signing = {
      key = "0x209101AD5F0E04C6";
      format = "openpgp";
      signByDefault = lib.mkDefault true;
      signer = "${config.programs.gpg.package}/bin/gpg2";
    };

    settings = {
      user = {
        name = lib.mkDefault "Marco Mihai Condrache";
        email = lib.mkDefault "52580954+marcocondrache@users.noreply.github.com";
      };

      extraConfig = {
        init.defaultBranch = "main";

        diff.algorithm = "histogram";
        merge.conflictStyle = "zdiff3";

        commit.verbose = true;

        push.autoSetupRemote = true;
        branch.sort = "committerdate";

        core.fsmonitor = true;
      };
    };

    ignores = [
      ".npmrc"
      ".direnv"
      ".devbox"
    ];
  };
}
