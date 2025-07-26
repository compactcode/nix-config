{delib, ...}:
delib.module {
  # bluetooth support
  name = "hardware.bluetooth";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };
  };

  nixos.ifDisabled = {
    boot = {
      # disable auto loading
      blacklistedKernelModules = [
        "bluetooth"
        "btbcm"
        "btintel"
        "btmtk"
        "btrtl"
        "btusb"
      ];
    };
  };
}
