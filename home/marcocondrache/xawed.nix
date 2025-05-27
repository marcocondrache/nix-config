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
