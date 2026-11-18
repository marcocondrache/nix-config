# UTM with the Apple Virtualization backend: every device is virtio
{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
  };

  # UTM exposes the shared directory under the "share" virtiofs tag
  fileSystems."/host" = {
    device = "share";
    fsType = "virtiofs";
    options = [
      "nofail"
      "x-systemd.automount"
    ];
  };
}
