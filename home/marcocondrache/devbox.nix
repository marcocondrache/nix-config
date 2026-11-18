{ pkgs, ... }:
{
  imports = [
    ./global
    ./features
  ];

  programs.mise.package = pkgs.mise;

  # The keys live on the YubiKey: the Mac forwards its gpg-agent into
  # /run/user/1000/gnupg over ssh, so a local agent must never claim that socket
  programs.gpg.settings.no-autostart = true;
  systemd.user.tmpfiles.rules = [ "d %t/gnupg 0700 - - -" ];
}
