{delib, ...}:
delib.module {
  name = "gtk";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    gtk = {
      enable = true;
      # stylix handles gtk4 theming via css; no named theme needed
      gtk4.theme = null;
    };

    stylix.targets.gtk = {
      enable = true;

      # flatpakSupport.enable = true;
    };
  };
}
