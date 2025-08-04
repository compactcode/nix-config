{
  delib,
  pkgs,
  ...
}:
delib.module {
  # clipboard manager
  name = "services.cliphist";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      pkgs.wl-clipboard # clipboard utilities
    ];

    services.cliphist.enable = true;
  };
}
