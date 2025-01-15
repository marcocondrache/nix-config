{
  lib,
  ...
}:
{
  programs.k9s = {
    enable = lib.mkDefault true;
  };
}
