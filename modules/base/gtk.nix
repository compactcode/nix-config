{delib, ...}:
delib.module {
  name = "gtk";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    gtk = {
      enable = true;
    };

    stylix.targets.gtk = {
      enable = true;

      # flatpakSupport.enable = true;
    };
  };
}
