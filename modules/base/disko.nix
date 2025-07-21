{
  delib,
  lib,
  inputs,
  ...
}:
delib.module {
  name = "disko";

  options.disko = with delib; {
    enable = boolOption true;
    device = noDefault (strOption null);
    encrypted = boolOption true;
  };

  nixos.always.imports = [inputs.disko.nixosModules.disko];

  nixos.ifEnabled = {cfg, ...}: {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = cfg.device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = lib.mkIf (!cfg.encrypted) {
              size = "100%";
              content = {
                type = "btrfs";
                subvolumes = {
                  "/root" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/nix";
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                  };
                };
              };
            };
            luks = lib.mkIf (cfg.encrypted) {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true; # improved ssd performance
                  bypassWorkqueues = true; # improved ssd performance
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/";
                    };
                    "/nix" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/nix";
                    };
                    "/persist" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/persist";
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "4G";
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
