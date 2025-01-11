{
  host,
  username,
  lib,
}:
{
  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
  };
}
