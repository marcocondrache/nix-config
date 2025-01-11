{
  lib,
  user,
  ...
}:
{
  home = {
    username = user;
    stateVersion = lib.mkDefault "24.11";
  };
}
