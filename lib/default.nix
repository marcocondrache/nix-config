{ inputs, ... }:
{
  mkSystem = import ./mksystem.nix { inherit inputs; };
}
