{
  lib,
  pkgs,
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
      g = "git";
      ce = "zed .";
      ls = lib.mkIf (hasPackage "eza") "eza";
      kf = lib.mkIf (hasPackage "kubef") "kubef";
      lg = lib.mkIf (hasPackage "lazygit") "lazygit";
      grep = lib.mkIf (hasPackage "ripgrep") "rg";
      exa = ls;
    };

    plugins =
      [ ]
      ++ lib.optional (hasPackage "zoxide") {
        name = "zoxide";
        src = pkgs.fetchFromGitHub {
          owner = "icezyclon";
          repo = "zoxide.fish";
          rev = "27a058a661e2eba021b90e9248517b6c47a22674";
          hash = "sha256-OjrX0d8VjDMxiI5JlJPyu/scTs/fS/f5ehVyhAA/KDM=";
        };
      };

    functions = {
      fish_greeting = "";
    };
  };
}
