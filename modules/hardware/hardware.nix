{delib, ...}:
delib.module {
  name = "hardware";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # enable nonfree firmware
    hardware.enableRedistributableFirmware = true;
  };
}
