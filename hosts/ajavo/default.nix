{
  user,
  ...
}:
{
  imports = [

    ../common/global
    ../common/optional/rpi.nix
    ../common/users/${user}
  ];
}
