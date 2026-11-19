{ inputs, ... }:
let
  utmNatInterface = "enp0s1";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./hardware.nix
    ./disko.nix
    ../common/global
    ../common/nixos
    ../common/users/marcocondrache/nixos.nix
  ];

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

  networking.firewall.trustedInterfaces = [ utmNatInterface ];

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "26.11";
}
