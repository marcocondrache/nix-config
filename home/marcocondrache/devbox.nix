{ pkgs, config, ... }:
{
  imports = [
    ./global
    ./features
    ./features/docker.nix
    ./features/work.nix
  ];

  programs.mise.package = pkgs.mise;

  # mise compiles from source on NixOS by default; nix-ld runs its prebuilt binaries
  programs.mise.globalConfig.settings.all_compile = false;

  home.packages = with pkgs; [
    # rustup and cargo need a cc to link; macOS gets one from Xcode
    gcc
    # mise installs cargo: tools as prebuilt binaries when this is on PATH
    cargo-binstall
  ];

  # No YubiKey in the VM, so sops decrypts with a key generated on the VM
  sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

  # Personal server for the Mac's Rex app over ssh://devbox; lingering keeps it alive
  services.rex.enable = true;

  # The keys live on the YubiKey: the Mac forwards its gpg-agent into
  # /run/user/1000/gnupg over ssh, so a local agent must never claim that socket
  programs.gpg.settings.no-autostart = true;
  systemd.user.tmpfiles.rules = [ "d %t/gnupg 0700 - - -" ];
  home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
  systemd.user.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
}
