{ lib, ... }:
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
    ../common/optional/sops.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  users.users.root.openssh.authorizedKeys.keys = lib.splitString "\n" (
    builtins.readFile ../../home/marcocondrache/ssh.pub
  );

  system.stateVersion = "25.05";
}
