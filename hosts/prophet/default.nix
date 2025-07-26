# CPU: Intel Core i7-8565U
# GPU: Nvidia Quadro P520
# Motherboard: ThinkPad P43s
{
  delib,
  inputs,
  ...
}:
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

    # enable feature sets
    features = {
      development.enable = true;
      cli.enable = true;
      hyprland.enable = true;
    };

    services = {
      nfs = {
        enable = true;
        shares = ["photos" "documents"];
      };
      tlp.enable = true;
    };
  };

  homeManagerSystem = "x86_64-linux";

  home.home.stateVersion = "24.05";

  nixos = {
    imports = [
      # configure intel cpu
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      # configure intel gpu
      inputs.nixos-hardware.nixosModules.common-gpu-intel
      # configure ssd
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      # disable nvidia gpu (to save power)
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable
    ];

    # modern scheduling for better efficiency
    boot.kernelParams = ["i915.enable_guc=2"];

    hardware = {
      # use newer encoding/decoding driver
      intelgpu.vaapiDriver = "intel-media-driver";

      # enable gpu acceleration
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    # fingerprint scanner
    services.fprintd.enable = true;

    networking.hostName = "prophet";

    nixpkgs.hostPlatform = "x86_64-linux";

    system.stateVersion = "24.05";
  };
}
