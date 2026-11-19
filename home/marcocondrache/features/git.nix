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

      init.defaultBranch = "main";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        sopsdiffer.textconv = "${lib.getExe pkgs.sops} decrypt";
      };
      commit.verbose = true;
      push.autoSetupRemote = true;
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      column.ui = "auto";
      help.autocorrect = "prompt";
      rerere = {
        enabled = true;
        autoUpdate = true;
      };
      fetch = {
        prune = true;
        writeCommitGraph = true;
      };
      rebase = {
        updateRefs = true;
        autoSquash = true;
        autoStash = true;
      };

      core = {
        untrackedcache = true;
      };

      alias = {
        f = "fetch";
        fa = "fetch --all --prune";
        p = "pull";

        ps = "push";
        psf = "push --force-with-lease";
        psu = "push -u origin HEAD";

        s = "status -sb";
        d = "diff";
        ds = "diff --staged";

        c = "commit";
        cm = "commit -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        caan = "commit --all --amend --no-edit";

        b = "branch";
        ba = "branch -a";
        bd = "branch -d";
        bdd = "branch -D";

        co = "checkout";
        cob = "checkout -b";
        sw = "switch";
        swp = "switch -";
        swd = "switch main";
        swc = "switch -c";
        swr = "!git switch -c \"$(LC_ALL=C tr -dc 'a-z' < /dev/urandom | head -c 8)\"";

        a = "add";
        aa = "add --all";
        ap = "add --patch";

        r = "rebase";
        ri = "rebase -i";
        rib = "!f() { git rebase -i $(git merge-base HEAD \${1:-main}); }; f";
        rc = "rebase --continue";
        ra = "rebase --abort";
        rom = "rebase origin/main";
        riom = "rebase -i origin/main";

        m = "merge";
        ma = "merge --abort";

        rs = "reset";
        rsh = "reset --hard";
        rss = "reset --soft";
        unstage = "reset HEAD --";

        st = "stash";
        stp = "stash pop";
        stl = "stash list";
        sta = "stash apply";
        std = "stash drop";

        l = "log --oneline -20";
        lg = "log --oneline --graph --all -20";
        ll = "log --pretty=format:'%C(yellow)%h%Creset %s %C(dim)— %an, %ar%Creset' -20";
        last = "log -1 HEAD --stat";

        cp = "cherry-pick";
        cpa = "cherry-pick --abort";
        cpc = "cherry-pick --continue";

        cl = "clone";
        wip = "commit -am 'WIP'";
        undo = "reset HEAD~1 --mixed";
        aliases = "config --get-regexp ^alias\\.";
      };
    };

    lfs.enable = true;

    ignores = [
      ".env"
      ".npmrc"
      ".direnv"
      ".DS_Store"
      "*.local.*"
      "*.local"
    ];
  };
}
