{
  ...
}:
{
  imports = [
    ./global
    ./features/desktop
    ./features/web
  ];

  # We don't use 1Password on this machine
  programs._1password-shell-plugins.enable = false;

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
