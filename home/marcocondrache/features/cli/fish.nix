{
  lib,
  config,
  darwin,
  osConfig,
  ...
}:
let
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasTailscale = darwin && osConfig.homebrew.enable && osConfig.homebrew.masApps.Tailscale != null;
  hasPackage = name: lib.any (x: x == name) packageNames;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      tailscale = lib.mkIf hasTailscale ''
        /Applications/Tailscale.app/Contents/MacOS/Tailscale
      '';
    };

    shellAbbrs = rec {
      ls = lib.mkIf (hasPackage "eza") "eza";
      cd = lib.mkIf (hasPackage "zoxide") "z";
      lg = lib.mkIf (hasPackage "lazygit") "lazygit";
      exa = ls;
    };

    functions = {
      fish_greeting = "";

      cd_git_root = ''
        if git rev-parse --git-dir &>/dev/null
          cd (git rev-parse --show-toplevel)
        else
          echo "Not in a git repository"
          return 1
        end
      '';

      cd = ''
        if test "$argv" = "..."
          cd_git_root
        else
          builtin cd $argv
        end
      '';
    };
  };
}
