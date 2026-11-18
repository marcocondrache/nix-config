{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./hardware.nix
    ./disko.nix
    ../common/global
    ../common/nixos
    ../common/users/marcocondrache/nixos.nix
  ];

  # Reachable from the Mac as devbox.local
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # Rotating IPv6 privacy addresses go stale in the Mac's mDNS cache
    settings.server.use-ipv6 = false;
    settings.publish = {
      disable-publishing = false;
      publish-addresses = true;
    };
  };

  # enp0s1 is UTM's NAT network, reachable only from the Mac: dev servers in
  # the VM open at http://devbox.local:<port>
  networking.firewall.trustedInterfaces = [ "enp0s1" ];

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "26.11";
}
