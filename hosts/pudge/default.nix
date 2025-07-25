# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023
{delib, ...}:
delib.host {
  name = "pudge";

  rice = "tokyo-night-storm";
  type = "server";

  myconfig = {
    disko = {
      enable = true;
      device = "/dev/disk/by-id/ata-AirDisk_512GB_SSD_NFG246R002163S30WX";
      encrypted = false;
    };

    # enable feature sets
    features = {
      cli.enable = true;
      homelab.enable = true;
    };
  };

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.11";

  nixos = {
    boot = {
      # disable wifi and bluetooth
      blacklistedKernelModules = [
        "bluetooth"
        "btbcm"
        "btintel"
        "btmtk"
        "btrtl"
        "btusb"
        "iwlwifi"
      ];

      initrd = {
        availableKernelModules = ["ahci" "sd_mod" "uas" "usb_storage" "usbhid" "xhci_pci"];
      };

      # enable virtualization
      kernelModules = ["kvm-intel"];
    };

    # enable microcode updates
    hardware.cpu.intel.updateMicrocode = true;

    nixpkgs.hostPlatform = "x86_64-linux";

    system.stateVersion = "23.05";
  };
}
