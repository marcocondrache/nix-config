{
  ...
}:
let
  workEnv = "$HOME/Work";
  personalEnv = "$HOME/Personal";
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
        commit.gpgsign = false;
      };
    }
  ];

  programs.zsh = {
    dirHashes = {
      # cd ~work or ~personal
      work = workEnv;
      personal = personalEnv;
    };
  };
}
