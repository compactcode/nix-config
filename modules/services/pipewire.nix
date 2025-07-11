{delib, ...}:
delib.module {
  # sound
  name = "services.pipewire";

  options = delib.singleEnableOption true;

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
