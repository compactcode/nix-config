{delib, ...}:
delib.module {
  # sound
  name = "services.pipewire";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # enable real-time scheduling
    security.rtkit.enable = true;

    services = {
      pipewire = {
        enable = true;
        # pulseaudio compatibility
        pulse.enable = true;
      };
    };
  };
}
