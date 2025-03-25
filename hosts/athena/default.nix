{ lib, ... }:
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

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking = {
    firewall = {
      checkReversePath = false;

      allowedTCPPorts = [
        4240 # health check
        4244 # hubble server
        4245 # hubble relay
        9962 # agent prometheus metrics
        9963 # operator prometheus metrics
        9964 # envoy prometheus metrics
      ];

      allowedUDPPorts = [ 8472 ];
    };

    interfaces.enp1s0.ipv4.routes = [
      {
        address = "169.254.169.254";
        prefixLength = 32;
      }
    ];
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.k3s = {
    serverAddr = "https://10.0.1.1:6443";
    extraFlags = [
      "--flannel-iface=enp7s0"
    ];
  };

  system.stateVersion = "25.05";
}
