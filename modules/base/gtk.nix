{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "gtk";

  options = {
    gtk = with delib; {
      enable = boolOption pkgs.stdenv.isLinux;
    };
  };

  home.ifEnabled = {
    gtk.enable = true;

    stylix.targets.gtk = {
      enable = true;
      flatpakSupport.enable = true;
    };
  };
}
