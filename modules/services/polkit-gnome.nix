{
  config,
  delib,
  ...
}:
delib.module {
  # authentication agent
  name = "services.polkit-gnome";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    services.polkit-gnome.enable = true;
  };

  nixos.ifEnabled = {
    # check the password before the fingerprint so typing a password is never
    # blocked by the scanner (submit an empty password to use the fingerprint)
    security.pam.services.polkit-1.rules.auth.fprintd.order =
      config.security.pam.services.polkit-1.rules.auth.unix.order + 50;
  };
}
