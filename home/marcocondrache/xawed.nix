{ config, ... }:
{
  imports = [
    ./global
    ./features
    ./features/darwin
    ./features/work.nix
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
