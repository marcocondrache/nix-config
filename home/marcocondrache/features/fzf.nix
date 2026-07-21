{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [ "--color 16" ];
    historyWidget.command = "";
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidget.command = "fd --type f --hidden --exclude .git";
    changeDirWidget.command = "fd --type d --hidden --exclude .git";
  };
}
