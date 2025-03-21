{
  imports = [
    ./services

    ./disk-configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/marcocondrache
    ../common/optional/openssh.nix
    ../common/optional/fail2ban.nix
    ../common/optional/persistence.nix
    ../common/optional/systemd-initrd.nix
    ../common/optional/ephemeral-btrfs.nix
    ../common/optional/tailscale-exit-node.nix
    ../common/optional/sops.nix
    ../common/optional/podman.nix
    ../common/optional/acme.nix
    ../common/optional/nginx.nix
    ../common/optional/nginx-cf.nix
    ../common/optional/sudo.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  system.stateVersion = "25.05";
}
