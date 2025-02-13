{
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
      condition = "gitdir/i:${workEnv}/**";
      contents = {
        commit.gpgSign = false;
        feature.manyFiles = true;
      };
    }
  ];
}
