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
