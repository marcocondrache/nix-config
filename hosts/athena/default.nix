{
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/marcocondrache
    ../common/optional/openssh.nix
    ../common/optional/fail2ban.nix
    ../common/optional/persistence.nix
    ../common/optional/systemd-initrd.nix
    ../common/optional/ephemeral-btrfs.nix
    ../common/optional/tailscale.nix
    ../common/optional/k3s-agent.nix
    ../common/optional/sops.nix
    ../common/optional/sudo.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.k3s = {
    serverAddr = "https://10.0.1.1:6443";
  };

  system.stateVersion = "25.05";
}
