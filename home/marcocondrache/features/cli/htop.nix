{
  lib,
  ...
}:
{
  programs.htop = {
    enable = lib.mkDefault true;
  };
}
