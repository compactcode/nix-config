{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.printing";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
      ];
    };
  };
}
