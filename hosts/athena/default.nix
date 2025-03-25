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

  networking = {
    firewall = {
      checkReversePath = lib.mkForce false;

      trustedInterfaces = [
        "enp7s0"
        "cilium_host"
        "cilium_net"
        "cilium_wg0"
        "cilium_vxlan"
        "lxc+"
      ];
    };

    interfaces.enp1s0.ipv4.routes = [
      {
        address = "169.254.169.254";
        prefixLength = 32;
      }
    ];

    interfaces.enp7s0.ipv4.routes = [
      {
        address = "10.42.0.0";
        prefixLength = 16;
        via = "10.0.0.1";
        options = {
          protocol = "kernel";
        };
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
