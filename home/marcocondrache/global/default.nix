{
  lib,
  username,
  ...
}:
{
  home = {
    inherit username;
    stateVersion = lib.mkDefault "24.11";
  };
}
