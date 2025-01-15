{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs_22
    corepack_22
  ];
}
