{ config, pkgs, ... }:
let
  # UTM is installed outside nix; utmctl drives the running app over Apple Events
  utmctl = pkgs.writeShellScriptBin "utmctl" ''
    exec /Applications/UTM.app/Contents/MacOS/utmctl "$@"
  '';
in
{
  # Development happens on devbox; the Mac only keeps what its own shell uses
  home.packages = [
    utmctl
    pkgs.eza
    pkgs.ripgrep
  ];

  xdg.enable = true;
  home.preferXdgDirectories = true;

  # Apple Virtualization VMs live inside the UTM process, so UTM has to run;
  # keep it out of the Dock and alive with no windows open
  targets.darwin.defaults."com.utmapp.UTM" = {
    HideDockIcon = true;
    ShowMenuIcon = true;
    KeepRunningAfterLastWindowClosed = true;
  };

  launchd.agents.devbox = {
    enable = true;
    config = {
      ProgramArguments = [
        "${utmctl}/bin/utmctl"
        "start"
        "--hide"
        "devbox"
      ];
      RunAtLoad = true;
    };
  };

  imports = [
    ./global
    ./features/atuin.nix
    ./features/fish
    ./features/git.nix
    ./features/gpg.nix
    ./features/nh.nix
    ./features/rex.nix
    ./features/ssh.nix
    ./features/zoxide.nix
    ./features/darwin
  ];

  # Fixed paths instead of ForwardAgent: Rex terminals on the VM aren't ssh
  # logins, so they never see a per-connection SSH_AUTH_SOCK
  programs.ssh.settings.devbox = {
    HostName = "devbox.local";
    RemoteForward = [
      "/run/user/1000/gnupg/S.gpg-agent ${config.programs.gpg.homedir}/S.gpg-agent.extra"
      "/run/user/1000/gnupg/S.gpg-agent.ssh ${config.programs.gpg.homedir}/S.gpg-agent.ssh"
    ];
  };
}
