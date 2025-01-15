{
  lib,
  ...
}:
{
  programs.zsh = {
    enable = lib.mkDefault true;

    autosuggestion = {
      enable = lib.mkDefault true;
    };

    syntaxHighlighting = {
      enable = lib.mkDefault true;
    };

    enableCompletion = lib.mkDefault true;
  };
}
