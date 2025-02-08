{
  lib,
  pkgs,
  darwin,
  ...
}:
let
  gpg-autostart = ''
    gpgconf --launch gpg-agent
  '';

  # https://github.com/nix-community/home-manager/pull/5901
  # temporary until PR is merged
  gpg-agent-env = ''
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket | string collect; or echo)
  '';
in
{
  programs.fish.loginShellInit = gpg-autostart;
  programs.fish.interactiveShellInit = gpg-agent-env;

  programs.gpg = {
    enable = lib.mkDefault true;
    publicKeys = [
      {
        source = ../../pgp.asc;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    sshKeys = [ "8A4248ED29B2E49BEA8D6D2560CD3EBBEADCE11D" ];
    maxCacheTtl = 120;
    defaultCacheTtl = 60;
  };

  systemd.user.services = lib.mkIf (!darwin) {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
