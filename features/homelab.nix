{delib, ...}:
delib.module {
  name = "features.homelab";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.podman.enable = true;
    services = {
      homeassistant.enable = true;
      media.enable = true;
      nfs = {
        enable = true;
        shares = {
          config.enable = true;
          media.enable = true;
        };
      };
    };
  };
}
