{
  ...
}:
let
  workEnv = "$HOME/Work";
  _personalEnv = "$HOME/Personal";
in
{
  imports = [
    ./global
    ./features/cli
    ./features/desktop
  ];

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}";
      contents = {
        commit.gpgSign = false;
        feature.manyFiles = true;
      };
    }
  ];
}
