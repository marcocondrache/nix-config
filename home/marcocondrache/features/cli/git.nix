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

    attributes = [
      "* merge=mergiraf"
    ];

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

        merge.mergiraf = {
          name = "mergiraf";
          driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
        };
      };
    };

    ignores = [
      ".npmrc"
      ".direnv"
      ".devbox"
    ];
  };
}
