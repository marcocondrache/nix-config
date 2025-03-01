{
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/marcocondrache
    ../common/optional/openssh.nix
    ../common/optional/persistence.nix
    ../common/optional/systemd-initrd.nix
    ../common/optional/ephemeral-btrfs.nix
    ../common/optional/tailscale-exit-node.nix
    ../common/optional/sops.nix
    # ../common/optional/litestream.nix
    ../common/optional/nginx.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "25.05";
}
