{delib, ...}:
delib.module {
  # notifications
  name = "services.mako";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.mako = {
      enable = true;
      settings = {
        # auto hide after 10 seconds
        default-timeout = 10 * 1000;
        # many application icons are ugly & unhelpful
        icons = false;
      };
    };

    # automatic styling
    stylix.targets.mako.enable = true;
  };
}
