# CPU: Intel Core i7-8565U
# GPU: Nvidia Quadro P520
# Motherboard: ThinkPad P43s
{delib, ...}:
delib.host {
  name = "prophet";

  rice = "catppuccin-mocha";
  type = "desktop";

  myconfig = {
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-KXG6AZNV512G_TOSHIBA_79CS12AKTYSQ";
    };

    hardware.bluetooth.enable = true;

    programs.hyprland.enable = true;

    services.tlp.enable = true;
  };

  homeManagerSystem = "x86_64-linux";

  home.home.stateVersion = "24.05";

  nixos = {
    boot = {
      # disable nvidia gpu
      blacklistedKernelModules = ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"];

      # disable nvidia gpu
      extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      initrd = {
        availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
      };
    };

    hardware = {
      # enable microcode updates
      cpu.intel.updateMicrocode = true;
      # enable gpu acceleration
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services = {
      # fingerprint scanner
      fprintd.enable = true;
      # periodic ssd maintenance
      fstrim.enable = true;
      # disable nvidia gpu
      udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
    };

    networking.hostName = "prophet";

    nixpkgs.hostPlatform = "x86_64-linux";

    system.stateVersion = "24.05";
  };
}
