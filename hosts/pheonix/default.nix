# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX
{
  delib,
  inputs,
  pkgs,
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

    # turn the monitor off when idle
    services.hypridle.idle.enable = true;
  };

  home = {
    wayland.windowManager.hyprland.settings = {
      # scale up for the 4k monitor
      monitor = [
        {
          output = "desc:Dell Inc. DELL U2725QE FH8GMF4";
          mode = "3840x2160@120";
          position = "auto";
          scale = 1.5;
        }
      ];

      # render xwayland apps at native resolution rather than upscaling them
      # blurrily - steam needs its ui scale set in the client itself
      config.xwayland.force_zero_scaling = true;
    };

    # amd gpu stats
    programs.btop.package = pkgs.btop.override {rocmSupport = true;};

    home.stateVersion = "23.11";
  };

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

    system.stateVersion = "23.11";
  };
}
