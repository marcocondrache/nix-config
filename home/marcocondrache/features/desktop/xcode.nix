{
  lib,
  ...
}:
{
  programs.xcode = {
    enable = lib.mkDefault true;
  };
}
