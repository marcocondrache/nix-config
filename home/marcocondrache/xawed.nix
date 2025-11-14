{ pkgs, ... }:
let
  workEnv = "~/Work";
in
{
  imports = [
    ./global
    ./features/cli
  ];

  programs.lazygit = {
    settings = {
      os = {
        editPreset = "vscode";
      };

      services = {
        "dev.azure.com" = "azuredevops:dev.azure.com/danfoss";
      };
    };
  };

  home.packages = with pkgs; [
    coder
    claude-code
  ];

  # Disable the login message
  home.file.".hushlogin" = {
    text = "";
  };

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}/";
      contents = {
        feature.manyFiles = true;
      };
    }

    # Private work configuration i cannot share
    {
      condition = "gitdir:${workEnv}/";
      path = "${workEnv}/.gitconfig";
    }
  ];

  programs.ssh.includes = [
    "${workEnv}/.ssh/config"
  ];

  programs.fish.shellAliases = {
    tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
  };
}
