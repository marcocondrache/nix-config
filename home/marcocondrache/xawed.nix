{ pkgs, config, ... }:
let
  workEnv = "${config.home.homeDirectory}/Work";
in
{
  imports = [
    ./global
    ./features
  ];

  home.packages = with pkgs; [
    coder
    claude-code
  ];

  # Disable the login message
  home.file.".hushlogin" = {
    text = "";
  };

  # Required by SSH connection multiplexing (ControlPath)
  home.file."Work/.ssh/sockets/.keep" = {
    text = "";
  };

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}/";
      contents = {
        feature.manyFiles = true;
        url."git@danfoss.github.com:".insteadOf = "git@github.com:";
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
        extraOptions = {
          ControlMaster = "auto";
          ControlPath = "${workEnv}/.ssh/sockets/%r@%h-%p";
          ControlPersist = "600";
        };
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
