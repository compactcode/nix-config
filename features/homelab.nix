{delib, ...}:
delib.module {
  name = "features.homelab";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.podman.enable = true;
    services = {
      emby.enable = true;
      homeassistant.enable = true;
      nfs = {
        enable = true;
        shares = {
          config.enable = true;
          media.enable = true;
        };
      };
      radarr.enable = true;
      sonarr.enable = true;
    };
  };
}
