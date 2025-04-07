{ lib, pkgs, ... }:
{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
      "cgroup_memory=1"
    ];
  };

  console.enable = false;

  services.udev.extraRules = ''
    ACTION=="add", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
    ACTION=="change", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
    ACTION=="online", ENV{ID_TYPE}=="disk", ENV{ID_BUS}=="usb", ENV{ID_BUS}="scsi"
  '';

  networking.useDHCP = true;
}
