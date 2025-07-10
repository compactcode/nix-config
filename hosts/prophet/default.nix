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

    services.hyprland.enable = true;
  };

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "24.05";

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.05";
  };
}
