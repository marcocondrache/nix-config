{
  inputs,
  outputs,
  nixpkgs,
  ...
}:
{
  mkSystem = import ./mksystem.nix { inherit inputs nixpkgs outputs; };
}
