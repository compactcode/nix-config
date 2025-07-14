{delib, ...}:
delib.module {
  name = "home-manager";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    home-manager = {
      useGlobalPkgs = true;
    };
  };
}
