{delib, ...}:
delib.module {
  name = "locale";

  options.locale = with delib; {
    enable = boolOption true;
    timeZone = strOption "Australia/Melbourne";
  };

  nixos.ifEnabled = {cfg, ...}: {
    i18n.defaultLocale = "en_US.UTF-8";

    # melbourne cbd
    location = {
      latitude = -37.814;
      longitude = 144.96332;
    };

    time.timeZone = cfg.timeZone;
  };
}
