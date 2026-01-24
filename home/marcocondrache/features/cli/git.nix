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

      init.defaultBranch = "main";
      diff.algorithm = "histogram";
      commit.verbose = true;
      push.autoSetupRemote = true;
      branch.sort = "committerdate";
      rerere.enabled = true;
      fetch.writeCommitGraph = true;

      core = {
        fsmonitor = true;
        untrackedcache = true;
      };

      maintenance = {
        auto = false;
        strategy = "incremental";
      };

      alias = {
        # Fetch & Pull
        f = "fetch";
        fa = "fetch --all --prune";
        p = "pull";
        pr = "pull --rebase";

        # Push
        ps = "push";
        psf = "push --force-with-lease";
        psu = "push -u origin HEAD";

        # Status & Diff
        s = "status -sb";
        d = "diff";
        ds = "diff --staged";
        dc = "diff --cached";

        # Commit
        c = "commit";
        cm = "commit -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        caan = "commit --all --amend --no-edit";

        # Branch
        b = "branch";
        ba = "branch -a";
        bd = "branch -d";
        bD = "branch -D";

        # Checkout & Switch
        co = "checkout";
        cob = "checkout -b";
        sw = "switch";
        swc = "switch -c";

        # Add
        a = "add";
        aa = "add --all";
        ap = "add --patch";

        # Rebase
        r = "rebase";
        ri = "rebase -i";
        rc = "rebase --continue";
        ra = "rebase --abort";
        rom = "rebase origin/main";
        riom = "rebase -i origin/main";

        # Merge
        m = "merge";
        ma = "merge --abort";

        # Reset
        rs = "reset";
        rsh = "reset --hard";
        rss = "reset --soft";
        unstage = "reset HEAD --";

        # Stash
        st = "stash";
        stp = "stash pop";
        stl = "stash list";
        sta = "stash apply";
        std = "stash drop";

        # Log
        l = "log --oneline -20";
        lg = "log --oneline --graph --all -20";
        ll = "log --pretty=format:'%C(yellow)%h%Creset %s %C(dim)— %an, %ar%Creset' -20";
        last = "log -1 HEAD --stat";

        # Cherry-pick
        cp = "cherry-pick";
        cpa = "cherry-pick --abort";
        cpc = "cherry-pick --continue";

        # Misc
        cl = "clone";
        wip = "commit -am 'WIP'";
        undo = "reset HEAD~1 --mixed";
        aliases = "config --get-regexp ^alias\\.";
      };
    };

    maintenance = {
      enable = true;
      repositories = [ ];
    };

    lfs.enable = true;

    ignores = [
      ".npmrc"
      ".direnv"
      ".devbox"
    ];
  };
}
