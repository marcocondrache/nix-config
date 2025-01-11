{
  user,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/${user}
    { baseHome = "/Users"; }
  ];

  system.stateVersion = 5;
}
