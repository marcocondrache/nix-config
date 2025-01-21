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

  programs.zsh = {
    dirHashes = {
      # cd ~work or ~personal
      work = "$HOME/Work";
      personal = "$HOME/Personal";
    };
  };

  # home.packages = with pkgs; [
  #   teams
  # ];
}
