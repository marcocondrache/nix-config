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
    ../common/optional/tailscale.nix
    ../common/optional/k3s-server.nix
    ../common/optional/sops.nix
    ../common/optional/podman.nix
    ../common/optional/acme.nix
    ../common/optional/sudo.nix
  ];

  services.tailscale = {
    useRoutingFeatures = "both";
  };

  networking = {
    firewall = {
      trustedInterfaces = [
        "enp7s0"

        "cilium_host"
        "cilium_net"
        "cilium_wg*"
        "lxc*"
      ];
    };

    interfaces.enp1s0.ipv4.routes = [
      {
        address = "169.254.169.254";
        prefixLength = 32;
      }
    ];
  };

  services.k3s = {
    # NOTE: using hetzner cloud provider
    extraFlags = [
      "--flannel-iface=enp7s0"
      "--disable-cloud-controller"
      "--kubelet-arg=cloud-provider=external"
      "--tls-san=atlas.tail13f4af.ts.net"
      "--tls-san=10.0.1.1"
    ];
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  system.stateVersion = "25.05";
}
