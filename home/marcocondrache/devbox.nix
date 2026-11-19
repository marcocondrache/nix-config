{
  pkgs,
  config,
  osConfig,
  inputs,
  ...
}:
let
  forwardedGpgAgentSsh = "/run/user/${
    toString osConfig.users.users.${config.home.username}.uid
  }/gnupg/S.gpg-agent.ssh";
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.rex.homeManagerModules.default
    ./global
    ./features
    ./features/docker.nix
    ./features/work.nix
  ];

  # mise compiles from source on NixOS by default; nix-ld runs its prebuilt binaries
  programs.mise.globalConfig.settings.all_compile = false;

  home.packages = with pkgs; [
    # rustup and cargo need a cc to link; macOS gets one from Xcode
    gcc
    # mise installs cargo: tools as prebuilt binaries when this is on PATH
    cargo-binstall
  ];

  sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

  services.rex.enable = true;

  programs.gpg.settings.no-autostart = true;
  systemd.user.tmpfiles.rules = [ "d %t/gnupg 0700 - - -" ];
  home.sessionVariables.SSH_AUTH_SOCK = forwardedGpgAgentSsh;
  systemd.user.sessionVariables.SSH_AUTH_SOCK = forwardedGpgAgentSsh;
}
