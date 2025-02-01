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
    ./features/web
  ];

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}";
      contents = {
        commit.gpgSign = false;
      };
    }
  ];
}
