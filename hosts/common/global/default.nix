{
  ...
}:
{
  imports = [
    ./nix.nix
    ./locale.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
