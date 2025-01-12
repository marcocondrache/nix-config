{
  user,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/${user}

    ../common/optional/darwin.nix
  ];

  system = {
    stateVersion = 5;
  };
}
