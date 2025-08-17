# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023
{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "pudge";

  rice = "tokyo-night-storm";
  system = "x86_64-linux";

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

    services.openssh.enable = true;
  };

  home.home.stateVersion = "22.11";

  nixos = {
    imports = [
      # configure intel cpu
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      # configure intel gpu
      inputs.nixos-hardware.nixosModules.common-gpu-intel
      # configure ssd
      inputs.nixos-hardware.nixosModules.common-pc-ssd
    ];

    boot = {
      # disable wifi
      blacklistedKernelModules = [
        "iwlwifi"
      ];

      initrd = {
        availableKernelModules = ["ahci" "sd_mod" "uas" "usb_storage" "usbhid" "xhci_pci"];
      };

      # enable virtualization
      kernelModules = ["kvm-intel"];
    };

    system.stateVersion = "23.05";
  };
}
