{delib, ...}:
delib.module {
  # screen locker
  name = "programs.hyprlock";

  options.programs.hyprlock = with delib; {
    enable = boolOption false;
    # unlock with fingerprint in parallel with password (requires fprintd)
    fingerprint.enable = boolOption false;
  };

  home.ifEnabled = {cfg, ...}: {
    programs.hyprlock = {
      enable = true;
      settings = {
        general.hide_cursor = true;
        auth.fingerprint.enabled = cfg.fingerprint.enable;
      };
    };

    # automatic styling
    stylix.targets.hyprlock.enable = true;
  };

  nixos.ifEnabled = {
    # allow hyprlock to perform authentication
    # hyprlock talks to fprintd directly, so pam only checks the password
    security.pam.services.hyprlock.fprintAuth = false;
  };
}
