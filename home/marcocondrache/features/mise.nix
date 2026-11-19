{
  pkgs,
  lib,
  ...
}:
{
  programs.mise = {
    enable = true;
    package = lib.mkDefault null;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = false;
    mutableSettings = true;

    globalConfig = {
      settings = {
        experimental = true;
        github = {
          credential_command = "${lib.getExe pkgs.gh} auth token";
        };
      };

      tools = {
        bun = "latest";
        claude = "latest";
        fnox = "latest";
        sofka = "latest";
      };
    };
  };

  programs.fish.shellAbbrs = {
    m = "mise";
    o = "opencode";
    k = "sofka";
  };

  programs.fish.interactiveShellInit = lib.mkAfter ''
    if command -q mise
      mise activate fish | source
    end

    function fish_command_not_found
      __fish_default_command_not_found_handler $argv
    end
  '';
}
