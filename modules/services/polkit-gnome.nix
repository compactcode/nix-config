{delib, ...}:
delib.module {
  # authentication agent
  name = "services.polkit-gnome";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.polkit-gnome.enable = true;
  };
}
