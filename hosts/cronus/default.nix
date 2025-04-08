{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # ./disk-configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/marcocondrache
    ../common/optional/openssh.nix
    ../common/optional/fail2ban.nix
    ../common/optional/persistence.nix
    ../common/optional/systemd-initrd.nix
    ../common/optional/sops.nix
    ../common/optional/sudo.nix

    ../common/optional/k3s-server.nix
  ];

  nix.settings.auto-optimise-store = false;

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  system.stateVersion = "25.05";
}
