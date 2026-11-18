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
    settings.publish = {
      disable-publishing = false;
      publish-addresses = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "26.11";
}
