{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "gtk";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    gtk = {
      enable = true;

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    stylix.targets.gtk = {
      enable = true;
      flatpakSupport.enable = true;
    };
  };
}
