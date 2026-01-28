{ pkgs, config, ... }:
let
  workEnv = "${config.home.homeDirectory}/Work";
in
{
  imports = [
    ./global
    ./features/cli
  ];

  home.packages = with pkgs; [
    coder
    claude-code
  ];

  # Disable the login message
  home.file.".hushlogin" = {
    text = "";
  };

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}/";
      contents = {
        feature.manyFiles = true;
        url."git@danfoss.github.com:".insteadOf = "git@github.com:";

        # Use SSH signatures instead of GPG for work repos
        gpg.format = "ssh";
        user.signingKey = "${workEnv}/.ssh/id_work_sk";
      };
    }

    # Private work configuration i cannot share
    {
      condition = "gitdir:${workEnv}/";
      path = "${workEnv}/.gitconfig";
    }
  ];

  programs.ssh = {
    matchBlocks = {
      danfossGithub = {
        host = "danfoss.github.com";
        hostname = "github.com";
        identitiesOnly = true;
        identityFile = "${workEnv}/.ssh/id_work_sk";
      };
    };

    includes = [
      "${workEnv}/.ssh/coder"
    ];
  };

  programs.fish.shellAliases = {
    tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
  };
}
