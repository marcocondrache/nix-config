{
  pkgs,
  ...
}:
{
  imports = [
    ./nix.nix
    ./locale.nix
  ];

  system.stateVersion = "24.11";
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
