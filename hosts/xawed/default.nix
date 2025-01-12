{
  user,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/${user}

    ../common/optional/darwin
  ];

  system = {
    stateVersion = 5;
  };
}
