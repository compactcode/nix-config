# CPU: Apple M4 Pro
# GPU: Apple M4 Pro
# Motherboard: Apple Macbook Pro 14" 2024
{delib, ...}:
delib.host {
  name = "alchemist";

  rice = "catppuccin";
  type = "desktop";

  homeManagerSystem = "aarch64-darwin";
  home.home.stateVersion = "24.05";

  darwin = {
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 5;
  };
}
