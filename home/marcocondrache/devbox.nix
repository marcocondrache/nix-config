{ pkgs, ... }:
{
  imports = [
    ./global
    ./features
  ];

  programs.mise.package = pkgs.mise;

  # nkl-sofka.cachix.org has no aarch64-linux build, and compiling it OOMs the installer
  programs.sofka.enable = false;

  # Personal server for the Mac's Rex app over ssh://devbox; lingering keeps it alive
  services.rex.enable = true;

  # The keys live on the YubiKey: the Mac forwards its gpg-agent into
  # /run/user/1000/gnupg over ssh, so a local agent must never claim that socket
  programs.gpg.settings.no-autostart = true;
  systemd.user.tmpfiles.rules = [ "d %t/gnupg 0700 - - -" ];
  home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
  systemd.user.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
}
