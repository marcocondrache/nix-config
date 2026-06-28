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
    settings = {
      "danfoss.github.com" = {
        HostName = "github.com";
        IdentitiesOnly = true;
        IdentityFile = "${workEnv}/.ssh/id_work_sk";
        ControlMaster = "auto";
        ControlPath = "${workEnv}/.ssh/sockets/%r@%h-%p";
        ControlPersist = "4h";
      };
    };

    includes = [
      "${workEnv}/.ssh/coder"
    ];
  };
}
