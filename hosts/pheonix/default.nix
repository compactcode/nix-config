# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX
{delib, ...}:
delib.host {
  name = "pheonix";

  rice = "catppuccin-mocha";
  type = "desktop";

  myconfig = {
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NF0NA04068A";
    };

    programs.hyprland.enable = true;
  };

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "23.11";

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
        availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
      };

      # load the GPU early in the book process
      kernelModules = ["amdgpu"];
    };

    hardware = {
      # enable gpu asap to improve boot resolution
      amdgpu.initrd.enable = true;
      # enable microcode updates
      cpu.amd.updateMicrocode = true;
      # enable firmware flashing
      keyboard.zsa.enable = true;
      # enable gpu acceleration
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    # enable gpu support for applications like btop
    nixpkgs.config.rocmSupport = true;

    services = {
      # periodic ssd maintenance
      fstrim.enable = true;
      # prevent pci devices (nvme) waking the system out of sleep
      udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
      '';
    };

    nixpkgs.hostPlatform = "x86_64-linux";

    system.stateVersion = "23.11";
  };
}
