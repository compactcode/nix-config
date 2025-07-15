{delib, ...}:
delib.module {
  name = "gtk";

  options = delib.singleEnableOption false;

  # TODO: figure out why this doesn't work when the same code does for xdg
  # options = {...}: {
  #   gtk = with delib; {
  #     enable = boolOption pkgs.stdenv.isLinux;
  #   };
  # };

  home.ifEnabled = {
    gtk.enable = true;
  };
}
