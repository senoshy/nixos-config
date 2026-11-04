{
  config,
  lib,
  ...
}: {
  disko.devices = {
    disk = {
      main = {
        # /dev/disk/by-id is stable across boots; avoids wiping the wrong disk
        device = "/dev/disk/by-id/ata-ADATA_SU650_2O362926Q5U1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  # pass TRIM through to the SSD; leaks which blocks are in use,
                  # acceptable tradeoff for SATA SSD longevity/perf
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "10G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
