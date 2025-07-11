# CPU: Apple M4 Pro
# GPU: Apple M4 Pro
# Motherboard: Apple Macbook Pro 14" 2024
{delib, ...}:
delib.host {
  name = "alchemist";

  rice = "catppuccin-mocha";
  type = "desktop";

  homeManagerSystem = "aarch64-darwin";
  home.home.stateVersion = "24.05";

  darwin = {myconfig, ...}: {
    nixpkgs.hostPlatform = "aarch64-darwin";

    # enable touch id for sudo
    security.pam.services.sudo_local.touchIdAuth = true;

    system = {
      defaults = {
        dock = {
          # only show on hover
          autohide = true;
          # only pin these apps
          persistent-apps = [
            "/System/Applications/Mail.app"
          ];
        };
      };

      keyboard = {
        # allow remap
        enableKeyMapping = true;
        # remap capslock to control
        remapCapsLockToControl = true;
      };

      stateVersion = 5;

      primaryUser = myconfig.users.primary.id;
    };
  };
}
