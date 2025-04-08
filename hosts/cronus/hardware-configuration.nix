{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;

    # https://github.com/envoyproxy/envoy/issues/23339
    # TODO: Consider using generic kernel instead
    # kernelPatches = [
    #   {
    #     name = "va-bits";
    #     patch = null;
    #     extraConfig = ''
    #       ARM64_VA_BITS_48 y
    #     '';
    #   }
    # ];

    kernelParams = [
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
      "cgroup_memory=1"
    ];

    initrd = {
      availableKernelModules = [
        "uas"
        "xhci_pci"
        "pcie-brcmstb"
        "reset-raspberrypi"
      ];
    };
  };

  console.enable = false;

  services.udev.extraRules = ''
    ACTION=="add", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
    ACTION=="change", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
    ACTION=="online", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
  '';

  networking.useDHCP = true;
}
