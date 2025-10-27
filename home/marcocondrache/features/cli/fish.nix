{
  lib,
  config,
  ...
}:
let
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
in
{
  programs.fish = {
    enable = true;

    shellAbbrs = rec {
      ce = "zed .";
      ls = lib.mkIf (hasPackage "eza") "eza";
      cd = lib.mkIf (hasPackage "zoxide") "z";
      kf = lib.mkIf (hasPackage "kubef") "kubef";
      lg = lib.mkIf (hasPackage "lazygit") "lazygit";
      grep = lib.mkIf (hasPackage "ripgrep") "rg";
      exa = ls;
    };

    functions = {
      fish_greeting = "";
    };
  };
}
