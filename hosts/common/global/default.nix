{
  pkgs,
  ...
}:
{
  imports = [
    ./nix.nix
    ./locale.nix
  ];

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
