{
  ...
}:
{
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/web
  ];

  programs.git.includes = [ { path = "local.conf"; } ];

  programs.zsh = {
    dirHashes = {
      # cd ~work or ~personal
      work = "$HOME/Work";
      personal = "$HOME/Personal";
    };
  };
}
