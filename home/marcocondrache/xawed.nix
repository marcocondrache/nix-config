{
  pkgs,
  ...
}:
let
  workEnv = "~/Work";
  _personalEnv = "~/Personal";
in
{
  imports = [
    ./global
    ./features/cli
    ./features/desktop
  ];

  home.packages = with pkgs; [
    coder
  ];

  # TODO: find a better way to do this
  home.sessionVariables = {
    CODER_SSH_CONFIG_FILE = "${workEnv}/.ssh/config";
  };

  programs.lazygit = {
    settings.services = {
      "dev.azure.com" = "azuredevops:dev.azure.com/danfoss";
    };
  };

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}/";
      contents = {
        tag.gpgSign = false;
        commit.gpgSign = false;
        feature.manyFiles = true;
      };
    }

    # Private work configuration i cannot share
    {
      condition = "gitdir:${workEnv}/";
      path = "${workEnv}/.gitconfig";
    }
  ];

  programs.ssh.includes = [
    "${workEnv}/.ssh/config"
  ];
}
