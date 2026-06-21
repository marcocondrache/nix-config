{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [ "--color 16" ];

    # Use fd so search respects .gitignore and includes dotfiles (but not .git)
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidgetCommand = "fd --type f --hidden --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --exclude .git";
  };
}
