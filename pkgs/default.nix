{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  xcode = pkgs.callPackage ./xcode { };
}
