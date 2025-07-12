{delib, ...}:
delib.module {
  name = "locale";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    i18n.defaultLocale = "en_US.UTF-8";

    # melbourne cbd
    location = {
      latitude = -37.814;
      longitude = 144.96332;
    };

    time.timeZone = "Australia/Melbourne";
  };
}
