{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.programs.gpg) homedir package;
in
{
  programs.gpg = {
    enable = lib.mkDefault true;
    publicKeys = [
      {
        source = ../pgp.asc;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    # pinentry_mac doesn't need the per-shell GPG_TTY/updatestartuptty refresh
    enableFishIntegration = false;
    pinentry.package = pkgs.pinentry_mac;
    sshKeys = [ "8A4248ED29B2E49BEA8D6D2560CD3EBBEADCE11D" ];

    defaultCacheTtl = 28800;
    defaultCacheTtlSsh = 28800;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
  };

  # gpg-agent --supervised only accepts systemd sockets, so the upstream launchd
  # agent exits 2 in a KeepAlive loop; launch the agent normally at login instead
  launchd.agents.gpg-agent.config = lib.mkForce {
    Label = "org.nix-community.home.gpg-agent";
    ProgramArguments = [
      "${package}/bin/gpgconf"
      "--launch"
      "gpg-agent"
    ];
    EnvironmentVariables.GNUPGHOME = homedir;
    RunAtLoad = true;
    AbandonProcessGroup = true;
  };

  sshAuthSock.initialization.fish = lib.mkForce "set -x SSH_AUTH_SOCK ${homedir}/S.gpg-agent.ssh";
}
