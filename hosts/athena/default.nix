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
    ../common/optional/k3s-server.nix
    ../common/optional/sops.nix
    ../common/optional/sudo.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # TODO: required for longhorn https://github.com/longhorn/longhorn/issues/2166
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  services.openiscsi = {
    enable = true;
    name = "athena";
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/longhorn" ];
  };

  system.stateVersion = "25.05";
}
