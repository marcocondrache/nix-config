{
  user,
  ...
}:
{
  imports = [
    ../common/global
    (import ../common/users/${user} { baseHome = "/Users"; })
  ];

  system.stateVersion = 5;
}
