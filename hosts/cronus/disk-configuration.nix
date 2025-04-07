{ host, ... }:
{
  disko.devices = {
    disk.${host} = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };

          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          root = {
            name = "root";
            size = "40G";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };

          empty = {
            name = "empty";
            size = "100%";
            type = "8300";
          };
        };
      };
    };

    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];

              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "subvol=root"
                    "compress=zstd"
                  ];
                };

                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "subvol=persist"
                    "compress=zstd"
                    "noatime"
                  ];
                };

                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "subvol=nix"
                    "compress=zstd"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
