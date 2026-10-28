{ pkgs, ... }:
{
  programs.fish = {
    plugins = [
      {
        name = "hydro";
        inherit (pkgs.fishPlugins.hydro) src;
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
