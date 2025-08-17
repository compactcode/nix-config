# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX
{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "pheonix";

  rice = "catppuccin-mocha";
  system = "x86_64-linux";

  myconfig = {
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NF0NA04068A";
    };

    # enable feature sets
    features = {
      development.enable = true;
      cli.enable = true;
      hyprland.enable = true;
    };
  };

  home.home.stateVersion = "23.11";

  nixos = {
    imports = [
      # configure amd cpu
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      # configure amd gpu
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      # configure ssd
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      # configure motherboard
      inputs.nixos-hardware.nixosModules.gigabyte-b550
    ];

    boot = {
      # disable wifi
      blacklistedKernelModules = [
        "iwlwifi"
      ];

      initrd = {
        availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
      };

      # load the GPU early in the boot process
      kernelModules = ["amdgpu"];
    };

    hardware = {
      # enable gpu asap to improve boot resolution
      amdgpu.initrd.enable = true;
      # enable firmware flashing
      keyboard.zsa.enable = true;
      # enable gpu acceleration
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    networking.hostName = "pheonix";

    nixpkgs = {
      # enable gpu support for applications like btop
      config.rocmSupport = true;
    };

    system.stateVersion = "23.11";
  };
}
