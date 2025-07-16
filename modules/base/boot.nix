{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "boot";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    boot = {
      loader = {
        # allow displaying boot options
        efi.canTouchEfiVariables = true;

        # use systemd as the boot manager
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      # use the latest kernel
      kernelPackages = pkgs.linuxPackages_latest;
    };

    stylix.targets.console.enable = true;
  };
}
