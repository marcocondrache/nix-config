{
  pkgs,
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

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];
}
