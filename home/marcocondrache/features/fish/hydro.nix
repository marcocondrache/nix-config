{ pkgs, ... }:
{
  programs.fish = {
    plugins = [
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "f130b55ee3eaf099eccf588e2a62e5447068d120";
          hash = "sha256-Dfq974KpD1mtQKznIlkXfZfDnSF/4MfLTA18Ak0LADE=";
        };
      }
    ];

    interactiveShellInit = ''
      set -g hydro_color_pwd $fish_color_cwd
      set -g hydro_color_git $fish_color_normal
      set -g hydro_color_error $fish_color_error
      set -g hydro_color_prompt $fish_color_normal
      set -g hydro_color_duration $fish_color_normal
      set -g hydro_color_start $fish_color_normal
    '';
  };
}
