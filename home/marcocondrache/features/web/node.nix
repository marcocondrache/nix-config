{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs_22 # Latest LTS
  ];
}
